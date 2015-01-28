#!/bin/bash
cowsay -f eyes Reconfiguring bootup files to mount USB as root filesystem again...
read -p "Press any key to continue... " -n1 -s

echo Unmounting whatever is on /media/usb1...
sudo umount /media/usb1
echo Mounting USB EXT4 partition 1 /dev/sda1 in /media/usb1 for now...
sudo mount /dev/sda1 /media/usb1

echo Copying over bootup files that will point to the USB for the root filesystem instead of SD...
sudo cp -v ~/primestationone/reference/etc/fstabForUsb /media/usb1/etc/fstab
sudo cp -v ~/primestationone/reference/boot/cmdlineForUsb.txt /boot/cmdline.txt

read -p "Press any key to continue rebooting... " -n1 -s
restart
