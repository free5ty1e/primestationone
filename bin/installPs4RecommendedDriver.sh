#!/bin/bash

echo "Installing PS4 recommended driver to allow bluetooth pairing..."

sudo apt update
sudo apt install build-essential libusb-1.0-0-dev usbutils pkg-config

pushd ~
echo "Compiling sixpairps4..."
gcc -o sixpairps4 primestationone/reference/ps4controller/sixpairps4.c -lusb-1.0
echo "Compiled:"
ls sixpairps4
sudo cp -v sixpairps4 /usr/local/bin/
echo "Installing udev rule to act like a PS4 to automate pairing when a ps4 controller is connected via USB"
# sudo cp -v primestationone/reference/etc/udev/rules.d/99-sixpairps4.rules /etc/udev/rules.d/
sudo cp -v primestationone/reference/etc/udev/rules.d/99-autopairps4bt.rules /etc/udev/rules.d/
echo "Reloading udev rules..."
sudo udevadm control --reload-rules
popd

echo "Applying DiscoverableTimeout = 0 and PairableTimeout = 0 to /etc/bluetooth/main.conf"
echo "Current contents of this file before modification are:"
cat /etc/bluetooth/main.conf
echo ""
sudo setConfParam.sh /etc/bluetooth/main.conf DiscoverableTimeout 0
sudo setConfParam.sh /etc/bluetooth/main.conf PairableTimeout 0
echo "/etc/bluetooth/main.conf modified to:"
cat /etc/bluetooth/main.conf
echo ""
echo "Restarting bluetooth service..."
sudo systemctl restart bluetooth

# echo "Reference https://retropie.org.uk/docs/PS4-Controller/ "

# sudo apt update
# sudo apt install python3-dev python3-pip pipx
# pipx install ds4drv
# pipx ensurepath
# pipx completions

# sudo wget https://raw.githubusercontent.com/chrippa/ds4drv/master/udev/50-ds4drv.rules -O /etc/udev/rules.d/50-ds4drv.rules
# sudo udevadm control --reload-rules
# sudo udevadm trigger

# echo "Testing controller now... Put the controller into pairing mode with Share and PS!"
# ds4drv --hidraw --led 000008

