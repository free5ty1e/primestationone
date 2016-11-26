#!/bin/bash

echo "Installing self-destructing auto-expand MODIFIED filesystem (from a SHRUNKEN image) script to run first thing upon next boot..."

# sudo rm /etc/profile.d/01-expand.sh 
# sudo cp -vf /home/pi/primestationone/reference/scripts/01-expand.sh /etc/profile.d/
# sudo chmod -x /etc/profile.d/01-expand.sh 
# ls /etc/profile.d -fl

# sudo cp -vf /home/pi/primestationone/reference/scripts/resize2fs_once /etc/init.d/
# sudo chmod +x /etc/init.d/resize2fs_once
sudo install -m 755 /home/pi/primestationone/reference/scripts/resize2fs_once /etc/init.d/
# sudo update-rc.d resize2fs_once defaults
sudo systemctl enable resize2fs_once
