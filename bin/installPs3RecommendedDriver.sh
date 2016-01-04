#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
fancy_console_message "Installing recommended PS3 controller drivers..." "bud-frogs"

echo Cleaning up and preparing to install the PS3 controller driver fresh...

echo Ensuring package management autofixes are applied if any are needed...
sudo dpkg --configure -a
sudo apt-get -fy install

sudo service sixad stop

echo Removing old driver...
sudo dpkg --remove sixad
sudo dpkg --remove qtsixa
sudo rm /usr/local/bin/sixpair



echo Now actually installing the recommended driver...
#sudo ~/RetroPie-Setup/retropie_packages.sh ps3controller
#installPs3DriverQtSixAdWithGasiaSupportFromSources.sh
installPs3DriverQtSixAdWithFakeSupportFromSources.sh
