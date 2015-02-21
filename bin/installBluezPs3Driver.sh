#!/bin/bash

cowsay -f calvin Building Bluez with PS3 sixaxis autopairing driver...
sudo apt-get update
sudo apt-get upgrade
sudo apt-get -y install libusb-dev libdbus-1-dev libglib2.0-dev libudev-dev libical-dev libreadline-dev

#wget https://www.kernel.org/pub/linux/bluetooth/bluez-5.19.tar.xz
#tar xJvf bluez-5.19.tar.xz
#cd bluez-5.19
pushd ~

echo Downloading bluez...
wget https://www.kernel.org/pub/linux/bluetooth/bluez-5.28.tar.xz
tar xJvf bluez-5.28.tar.xz
cd bluez-5.28

echo Configuring...
./configure --prefix=/usr --mandir=/usr/share/man \
--sysconfdir=/etc --localstatedir=/var \
--disable-systemd --enable-sixaxis

echo Compiling...
make

echo Disabling sixad if installed on startup so the two sixaxis drivers dont interfere...
sudo update-rc.d -f sixad remove

echo Removing old Bluez...
sudo apt-get remove --purge bluez

echo Installing new Bluez...
sudo make install
sudo install -v -dm755 /etc/bluetooth
sudo install -v -m644 src/main.conf /etc/bluetooth/main.conf

echo Installing init script and set to enable at startup...
sudo cp -v ~/primestationone/reference/etc/init.d/bluetooth /etc/init.d/
chmod +x /etc/init.d/bluetooth
sudo update-rc.d bluetooth defaults
sudo dpkg --configure -a --force-confold

popd
