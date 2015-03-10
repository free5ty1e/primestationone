#!/bin/bash

cowsay -f calvin Building Bluez with PS3 sixaxis autopairing driver...
sudo apt-get update
#sudo apt-get -y upgrade
sudo apt-get -y install libusb-dev libdbus-1-dev libglib2.0-dev libusb-dev libdbus-1-dev libglib2.0-dev automake libudev-dev libical-dev libreadline-dev
cleanupTempFiles.sh

#wget https://www.kernel.org/pub/linux/bluetooth/bluez-5.19.tar.xz
#tar xJvf bluez-5.19.tar.xz
#cd bluez-5.19
pushd ~

echo Disabling sixad if installed on startup so the two sixaxis drivers dont interfere...
sudo update-rc.d -f sixad remove

echo Removing old Bluez...
sudo apt-get -y remove --purge bluez

echo Downloading new bluez 5...
rm bluez-5.28.tar.xz
rm -rf bluez-5.28
wget https://www.kernel.org/pub/linux/bluetooth/bluez-5.28.tar.xz
tar xJvf bluez-5.28.tar.xz
cd bluez-5.28

echo Configuring new bluez 5...
sudo ./configure --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc --localstatedir=/var --disable-systemd --enable-sixaxis

echo Compiling new bluez 5...
sudo make

echo Installing new bluez 5...
sudo make install
sudo install -v -dm755 /etc/bluetooth
sudo install -v -m644 src/main.conf /etc/bluetooth/main.conf

echo Installing init script for bluez 5 and set to enable at startup...
sudo cp -v ~/primestationone/reference/etc/init.d/bluetooth /etc/init.d/
sudo chmod +x /etc/init.d/bluetooth
sudo update-rc.d bluetooth defaults
#sudo dpkg --configure -a --force-confold

sudo -s cat > /etc/udev/rules.d/10-local.rules << _EOF_
# Set bluetooth power up and p/i scan enabled
ACTION=="add", KERNEL=="hci0", RUN+="/usr/bin/hciconfig hci0 up piscan"
_EOF_

sudo /etc/init.d/bluetooth start

ps3TrustUsbControllerForBluezBluetooth.sh

popd
