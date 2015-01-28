#!/bin/bash
cowsay -f eyes Reconfiguring bootup files to mount SD card second partition as root filesystem like stock Pi...
read -p "Press any key to continue... " -n1 -s

echo Unmounting whatever is on /media/usb1...
sudo umount /media/usb1
echo Mounting EXT4 partition 2 on SD card in /media/usb1 for now...
sudo mount /dev/mmcblk0p2 /media/usb1

echo Copying over bootup files that will point to the SD card for the root filesystem instead of USB...
sudo cp -v ~/primestationone/reference/etc/fstabForSd /media/usb1/etc/fstab
sudo cp -v ~/primestationone/reference/boot/cmdlineForSd.txt /boot/cmdline.txt

read -p "Press any key to continue rebooting... " -n1 -s
restart
