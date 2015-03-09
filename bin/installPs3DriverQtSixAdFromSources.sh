#!/bin/bash

cowsay -f bud-frogs Installing PS3 driver QtSixAd and sixpair from sources...
echo =====================> Installing Sixad PS3 sixaxis controller bluetooth pairing daemon qtsixad and compatible bluez from apt...
pushd ~
sudo apt-get -y install bluez-utils bluez-compat bluez-hcidump checkinstall libusb-dev libbluetooth-dev joystick
cleanupTempFiles.sh



wget -nv http://www.pabr.org/sixlinux/sixpair.c -O "sixpair.c"
wget -O- -q http://sourceforge.net/projects/qtsixa/files/QtSixA%201.5.1/QtSixA-1.5.1-src.tar.gz | tar -xvz
#--strip-components=1

sudo gcc -o sixpair sixpair.c -lusb
pushd QtSixA-1.5.1/sixad
sudo make clean
sudo make CXX="g++-4.6" CXXFLAGS="-O2"
#sudo make install
sudo mkdir -p /var/lib/sixad/profiles
sudo checkinstall -y --fstrans=no
sudo update-rc.d sixad defaults

popd
#sudo rm -rf QtSixA-1.5.1
popd
