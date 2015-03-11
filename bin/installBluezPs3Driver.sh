#!/bin/bash

BLUEZ_FILE="bluez-5.28"

cowsay -f calvin Building Bluez with PS3 sixaxis autopairing driver...
sudo apt-get update
#sudo apt-get -y upgrade
sudo apt-get -y install libusb-dev libdbus-1-dev libglib2.0-dev libusb-dev libdbus-1-dev libglib2.0-dev automake libudev-dev libical-dev libreadline-dev

echo Disabling sixad if installed on startup so the two sixaxis drivers dont interfere...
sudo update-rc.d -f sixad remove

echo Removing old Bluez...
sudo apt-get -y remove --purge bluez

cleanupTempFiles.sh

pushd ~

echo Stopping any current Bluez 5.x...
sudo /etc/init.d/bluetooth stop

echo "Downloading new $BLUEZ_FILE..."
rm "$BLUEZ_FILE.tar.xz"
rm -rf "$BLUEZ_FILE"
wget "https://www.kernel.org/pub/linux/bluetooth/$BLUEZ_FILE.tar.xz"
tar xJvf "$BLUEZ_FILE.tar.xz"
cd "$BLUEZ_FILE"

echo "Configuring new $BLUEZ_FILE..."
sudo ./configure --prefix=/usr --mandir=/usr/share/man --sysconfdir=/etc --localstatedir=/var --disable-systemd --enable-sixaxis

echo "Compiling new $BLUEZ_FILE..."
sudo make

echo "Installing new $BLUEZ_FILE..."
sudo make install
sudo install -v -dm755 /etc/bluetooth
sudo install -v -m644 src/main.conf /etc/bluetooth/main.conf

echo "Installing init script for $BLUEZ_FILE and set to enable at startup..."
sudo cp -v ~/primestationone/reference/etc/init.d/bluetooth /etc/init.d/
sudo chmod +x /etc/init.d/bluetooth
sudo update-rc.d bluetooth defaults
sudo dpkg --configure -a --force-confold

sudo bash -c 'cat > /etc/udev/rules.d/10-local.rules << _EOF_
# Set bluetooth power up and p/i scan enabled
ACTION=="add", KERNEL=="hci0", RUN+="/usr/bin/hciconfig hci0 up piscan"
_EOF_'

sudo /etc/init.d/bluetooth start

trustAllEncounteredPs3ControllersBluez5.sh

popd
