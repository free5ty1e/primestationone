#!/bin/bash

cowsay -f bud-frogs Installing PS3 Bluetooth Daemon...
echo Installing Sixad PS3 sixaxis controller bluetooth pairing daemon qtsixad and compatible bluez from apt...
pushd ~
sudo apt-get -y install libbluetooth3 bluez bluez-utils bluez-compat bluez-hcidump bluetooth
cleanupTempFiles.sh
tar xfvz QtSixA-1.5.1.tar.gz
#wget http://sourceforge.net/projects/qtsixa/files/QtSixA%201.5.1/QtSixA-1.5.1-src.tar.gz
#tar xfvz QtSixA-1.5.1-src.tar.gz
cd QtSixA-1.5.1/sixad
##wget https://bugs.launchpad.net/qtsixa/+bug/1036744/+attachment/3260906/+files/compilation_sid.patch
#cp ~/primestationone/reference/qtsixad/compilation_sid.patch .
#patch -Np1 -i compilation_sid.patch
#patch -Np1 -i ../sixad.pi.patch
#sudo make
sudo make install
sudo mkdir -p /var/lib/sixad/profiles
#sudo checkinstall -y
#cowsay -f calvin Disconnect your PS3 controller from the Pi USB cable, then press the center PS button, then Enter...
#pause 'Please ensure that PS3 controller is now disconnected from the USB, then press the center PS button, then press Enter to continue...'
#sudo sixad --start
sudo update-rc.d sixad defaults
cd ../..
#sudo rm -rf QtSixA-1.5.1
popd
