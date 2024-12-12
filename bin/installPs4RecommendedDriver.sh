#!/bin/bash

echo "Installing PS4 recommended driver to allow bluetooth pairing..."

sudo apt update
sudo apt install build-essential libusb-1.0-0-dev usbutils pkg-config

pushd ~
echo "Compiling sixpairps4..."
gcc -o sixpairps4 primestationone/reference/ps4controller/sixpairps4.c -lusb-1.0
echo "Compiled:"
ls sixpairps4
popd

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

