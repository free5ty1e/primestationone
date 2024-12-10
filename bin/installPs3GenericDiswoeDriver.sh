#!/bin/bash

echo "Adding support for stubborn 3rd party ps3 controllers to pair via bluetooth..."

# sudo ~/RetroPie-Setup/retropie_packages.sh "sixaxis"
# sudo ~/RetroPie-Setup/retropie_packages.sh "customhidsony"

#Sixpair to set bluetooth master for USB-connected ps3 controller
# sudo ~/RetroPie-Setup/retropie_packages.sh "ps3controller"
# sudo cleanupTempFiles.sh
sudo apt-get install bluez-utils bluez-compat bluez-hcidump checkinstall libusb-dev libbluetooth-dev joystick
sudo apt-get -y remove cups
sudo apt-get -y autoremove
# wget http://www.pabr.org/sixlinux/sixpair.c
cp ~/primestationone/reference/ps3controller/ps3DiswoePair.c ~/
push ~
gcc -o ps3DiswoePair ps3DiswoePair.c -lusb
sudo cp -v ps3DiswoePair /usr/local/bin/
popd
