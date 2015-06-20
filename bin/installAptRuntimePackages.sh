#!/bin/bash

echo Applying package manager fixes...
sudo apt-get clean
sudo dpkg --configure -a
sudo apt-get -yf install

echo Obtaining runtime packages / dependencies required for the basics for just running PrimeStationOne...
sudo apt-get install -y git dialog wicd-curses joystick ntfs-3g cowsay imagemagick angband pv bc
#libbluetooth3 bluez bluez-utils bluez-compat bluez-hcidump bluetooth
