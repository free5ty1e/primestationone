#!/bin/bash

echo "Installing self-destructing auto-expand filesystem script to run first thing upon next boot..."
sudo cp -vf /home/pi/primestationone/reference/scripts/01-expand.sh /etc/profile.d/
