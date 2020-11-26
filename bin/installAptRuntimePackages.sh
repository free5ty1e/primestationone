#!/bin/bash

echo Applying package manager fixes...
sudo apt-get clean
sudo dpkg --configure -a
sudo apt-get -yf install

echo "Obtaining runtime packages / dependencies required for the basics for just running PrimeStationOne..."
sudo apt-get install -y git dialog joystick ntfs-3g cowsay imagemagick angband pv bc libssl-dev glib-networking expect openssl gdisk rsync zip unzip tree
sudo apt-get install -y libav-tools

installGoAndAnsize.sh
#libbluetooth3 bluez bluez-utils bluez-compat bluez-hcidump bluetooth wicd-curses
