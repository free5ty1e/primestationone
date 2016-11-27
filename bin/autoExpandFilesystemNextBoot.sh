#!/bin/bash

echo "Installing self-destructing auto-expand MODIFIED filesystem (from a SHRUNKEN image) script to run first thing upon next boot..."

# sudo rm /etc/profile.d/01-expand.sh 
# sudo cp -vf /home/pi/primestationone/reference/scripts/01-expand.sh /etc/profile.d/
# sudo chmod -x /etc/profile.d/01-expand.sh 
# ls /etc/profile.d -fl

sudo cp -vf /home/pi/primestationone/reference/scripts/auto_expand_rootfs /etc/init.d/
sudo chmod +x /etc/init.d/auto_expand_rootfs
sudo update-rc.d auto_expand_rootfs defaults
