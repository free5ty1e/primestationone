#!/bin/bash
cowsay -f eyes Configuring first USB stick to be our new root filesystem!  Using /dev/sda1...
ls /dev/sd*
df -h
ls /media/usb0

read -p "Press any key to continue auto expanding filesystem on /dev/sda1... " -n1 -s

echo Now expanding filesystem to fill USB drive capacity...
sudo resize2fs -p /dev/sda1
df -h

read -p "Press any key to continue rebooting... " -n1 -s
restart
