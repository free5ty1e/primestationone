#!/bin/bash
cowsay -f eyes Configuring first USB stick to be our new root filesystem!  Using /dev/sda1...
ls /dev/sd*
df -h
ls /media/usb0

read -p "Press any key to continue -- DO NOT RUN THIS IF YOU ALREADY ARE RUNNING YOUR PI ROOT FROM USB! -- or CTRL-C to cancel using /dev/sda1... " -n1 -s

echo Unmounting USB drive...
sudo umount /dev/sda1

echo Now we need to remove all partitions on the USB drive.
echo List partitions by typing p ENTER
echo Then delete all partitions in reverse order as necessary, full delete commands are:
echo d ENTER 4 ENTER d ENTER 3 ENTER d ENTER 2 ENTER d ENTER
echo Then press n ENTER ENTER ENTER ENTER ENTER w ENTER to write changes...
sudo fdisk /dev/sda

echo Formatting EXT4 filesystem on USB drive...
sudo mkfs.ext4 /dev/sda1

echo Check new filesystem...answer yes to any autofix prompts...
sudo e2fsck /dev/sda1

echo Now replacing fstab and boot cmdline with versions that mount the USB as the root filesystem instead of the 2nd partition of the SD card, which we should be able to safely remove after this is complete...
sudo cp -v ~/primestationone/reference/etc/fstabForUsb /etc/fstab
sudo cp -v ~/primestationone/reference/boot/cmdlineForUsb.txt /boot/cmdline.txt

echo Removing USB copyroms service...
sudo rm /etc/usbmount/mount.d/01_retropie_copyroms

echo Installing package progressview pv so we can see something happening during the next big operation...
sudo apt-get install -y pv

cowsay -f tux Transferring entire root filesystem from SD to USB!!
echo Now actually transferring entire root filesystem to USB drive so we can boot from it...using pv with estimate of 4GB to transfer, so do not be alarmed if the progress does not reach 100 percent...
#sudo dd if=/dev/root of=/dev/sda1 bs=4M
sudo pv --size 4000000000 /dev/root | sudo dd bs=4M of=/dev/sda1

echo Checking new root filesystem...press enter to auto fix any issues that you are prompted for...
sudo e2fsck -f /dev/sda1

echo Now going to auto expand your USB filesystem to fill the drive.  If you want to manually manage your partitions, or do not want to resize at this time, hit CTRL-C to cancel.
echo This is the last step before a reboot, so just reboot to finish if you skip this next step.
usbSda1ExpandFilesystem.sh

read -p "Press any key to continue rebooting... " -n1 -s
restart
