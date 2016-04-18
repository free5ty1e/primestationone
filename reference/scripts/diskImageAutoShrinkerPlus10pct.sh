#!/bin/bash
# Automatic Image file resizer
# Written by SirLagz
# Fixed 2016.04.17 by @ChrisPrimeish 
strImgFile=$1

if [[ ! $(whoami) =~ "root" ]]; then
echo ""
echo "**********************************"
echo "*** This should be run as root ***"
echo "**********************************"
echo ""
exit
fi

if [[ -z $1 ]]; then
echo "Usage: ./autosizer.sh "
exit
fi

#|| ! $(file $1) =~ "x86"
if [[ ! -e $1 ]]; then
echo "Error : Not an image file, or file doesn't exist"
exit
fi

loopback=/dev/loop3
echo "Mounting $1 as loopback device $loopback..."
losetup -P "$loopback" $1

#partinfo=`parted --script --machine "$loopback" unit B print`
echo "Please type the following twice to proceed:"
echo "i"
echo "<ENTER>"
partinfo=`parted -m $loopback unit B print`

echo "Partition info for $loopback:"
echo "$partinfo"
partnumber=`echo "$partinfo" | grep ext4 | awk -F: ' { print $1 } '`
#partnumber=2
echo "ext4 partition found, partition number is $partnumber"
#loopextpart="$loopbackp$partnumber"
loopextpart=/dev/loop3p2
echo "ext4 partition loopback device constructed: $loopextpart"
partstart=`echo "$partinfo" | grep ext4 | awk -F: ' { print substr($2,0,length($2)) } '`
#partstart=`echo "$partinfo" | grep ext4 | awk -F: ' { print substr($2,0,length($2)-1) } '`
echo "ext4 partition starts at offset $partstart"
#loopback=`losetup -f --show -o $partstart $1`

echo "Press enter to continue if you have valid data above..."
read	#pause

echo "This next step might complain about superblock or partition table corruption, answer N to the abort prompt if it comes up:"

echo "Unmounting partitions..."
#umount /dev/loop3p1
umount /dev/loop3p2

e2fsck -f $loopextpart

#echo "Remounting $1 as loopback device $loopback..."
#losetup -d $loopback
#losetup -P "$loopback" $1

minsize=`resize2fs -P $loopextpart | awk -F': ' ' { print $2 } '`
echo "Minimum size of ext4 partition determined to be $minsize"

# Modified minsize calc by Kevin Rattai
#
# original minsize produces 0bytes on partition, calculated as:
# minsize=`echo "$minsize+1000" | bc`
#
# New minsize calc produces 10% minsize as available space
minsize=`echo "($minsize+($minsize*0.1))/1" | bc`
echo "Adding 10 percent to minimum size to leave a little breathing room, now is $minsize.  Resizing filesystem after you press enter to continue..."

read 	#pause

resize2fs -p $loopextpart $minsize
e2fsck -fy $loopextpart
echo "Resizing ext4 filesystem on $loopextpart to $minsize complete!"
sleep 1
partnewsize=`echo "$minsize * 4096" | bc`
echo "Partition new size $partnewsize"
newpartend=`echo "$partstart + $partnewsize" | bc`
echo "New partition end offset $newpartend... removing original ext4 partition table entry..."
part1=`parted --script "$loopback" rm 2`
echo "Creating new shrunken ext4 partition table entry..."
part2=`parted --script "$loopback" unit B mkpart primary $partstart $newpartend`
endresult=`parted --script --machine "$loopback" unit B print free | tail -1 | awk -F: ' { print substr($2,0,length($2)-1) } '`

echo "Unmounting partitions..."
umount /dev/loop3p1
umount /dev/loop3p2

losetup -d $loopback
echo "Disconnected and unmounted $loopback!"

echo "About to truncate $endresult bytes from $1 after shrinking ext4 partition..."
truncate --size=-$endresult $1
echo "Complete, for all you know!"

