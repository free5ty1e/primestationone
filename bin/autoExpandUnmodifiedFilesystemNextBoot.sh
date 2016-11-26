#!/bin/bash

echo "Installing self-destructing auto-expand UNMODIFIED (i.e., NOT from a shrunken image!) filesystem script to run first thing upon next boot..."

sudo install -m 755 /home/pi/primestationone/reference/scripts/resize2fs_once_from_unmodified_image /etc/init.d/
sudo systemctl enable resize2fs_once_from_unmodified_image
