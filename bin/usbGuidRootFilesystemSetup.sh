#!/bin/bash
cowsay -f eyes Configuring first USB stick to be our new root filesystem!  Using /dev/sda1 with GUID partition table...
ls /dev/sd*
df -h
ls /media/usb0

echo "See http://www.raspberrypi.org/forums/viewtopic.php?f=29&t=44177 for more information on this procedure..."
read -p "Press any key to continue -- DO NOT RUN THIS IF YOU ALREADY ARE RUNNING YOUR PI ROOT FROM USB! -- or CTRL-C to cancel using /dev/sda1... " -n1 -s

echo Unmounting USB drive, which can be mounted twice in some cases...
sudo umount /dev/sda1
sudo umount /dev/sda1

echo Installing gdisk to handle GUID partition table initialization...
sudo apt-get -y install gdisk rsync
cleanupTempFiles.sh


echo Now to zap all partitioning tables currently on the USB drive...
echo Type x ENTER to get to the eXperts menu
echo Type Z ENTER y ENTER y ENTER to zap all partitioning tables...
sudo gdisk /dev/sda

echo Now we need to create an appropriate partition on the USB drive.
echo Type n ENTER ENTER ENTER ENTER ENTER w ENTER y ENTER to write changes...
sudo gdisk /dev/sda
#echo Type i to see info after this to view GUID and note this value... then q to quit once you have it.
usbDiskGuid=$(sudo gdisk -l /dev/sda | grep GUID | awk '{print $4}')
echo "USB device GUID retrieved: $usbDiskGuid"

echo Here is where we need to set the /boot/cmdline.txt to point to root=PARTUUID=partitionguidhere along with rootdelay=5 at the end...
echo "Replacing GUID placeholder in new /boot/cmdline.txt with GUID $usbDiskGuid..."
sed "s/\${partitionguid}/$usbDiskGuid/" ~/primestationone/reference/boot/cmdlineForGuidUsb.txt > ~/cmdline.txt
sudo cp /boot/cmdline.txt ~/cmdline.txt.bak
sudo rm /boot/cmdline.txt
sudo cp ~/cmdline.txt /boot/cmdline.txt
rm ~/cmdline.txt

echo Ensuring USB drive is unmounted again...
sudo umount /dev/sda1
sudo umount /dev/sda1

echo Now continuing with ext4 filesystem setup and formatting...
sudo mke2fs -t ext4 -L rootfs /dev/sda1

echo Mounting new USB filesystem...
sudo mount /dev/sda1 /mnt

echo Transferring root filesystem to USB drive...
sudo rsync -axvh --progress / /mnt

echo Now we need to get a unique identifier for the fstab drive information...
echo Note the Filesystem UUID in the below info for usage in the fstab...
sudo tune2fs -l /dev/sda1
usbPart1FilesystemUuid=$(sudo tune2fs -l /dev/sda1 | grep UUID | awk '{print $3}')
echo "USB Partition 1 Filesystem UUID retrieved: $usbPart1FilesystemUuid"

echo Now modifying /etc/fstab to mount our UUID as the root mount point upon startup...
sed "s/\${partitionuuid}/$usbPart1FilesystemUuid/" ~/primestationone/reference/etc/fstabForUsbGuid > ~/fstab
sudo cp /mnt/etc/fstab ~/fstab.bak
sudo rm /mnt/etc/fstab
sudo cp ~/fstab /mnt/etc/fstab
rm ~/fstab

echo Removing USB copyroms service...
sudo rm /mnt/etc/usbmount/mount.d/01_retropie_copyroms

#echo Checking new root filesystem...press enter to auto fix any issues that you are prompted for...
#sudo e2fsck -f /dev/sda1
#
#echo Now going to auto expand your USB filesystem to fill the drive.  If you want to manually manage your partitions, or do not want to resize at this time, hit CTRL-C to cancel.
#echo This is the last step before a reboot, so just reboot to finish if you skip this next step.
#usbSda1ExpandFilesystem.sh

read -p "Press any key to continue rebooting... " -n1 -s
restart
