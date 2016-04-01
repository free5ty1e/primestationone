#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
fancy_console_message "Uninstalling PS3 controller drivers..." "bud-frogs"

echo "Uninstalling && cleaning up && preparing to install the PS3 controller driver fresh..."

echo Ensuring package management autofixes are applied if any are needed...
sudo dpkg --configure -a
sudo apt-get -fy install

sudo service sixad stop

echo Removing old driver...
sudo dpkg --remove sixad
sudo dpkg --remove qtsixa
sudo rm /usr/local/bin/sixpair
echo "Uninstall complete, if you didn't just see any errors!"
