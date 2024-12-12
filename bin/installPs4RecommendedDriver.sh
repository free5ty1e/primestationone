#!/bin/bash

echo "Installing PS4 recommended driver to allow bluetooth pairing... ensure PS4 controller is plugged in to test with"
echo "Reference https://retropie.org.uk/docs/PS4-Controller/ "

sudo apt update
sudo apt install python3-dev python3-pip pipx
sudo pipx install ds4drv
pipx ensurepath

sudo wget https://raw.githubusercontent.com/chrippa/ds4drv/master/udev/50-ds4drv.rules -O /etc/udev/rules.d/50-ds4drv.rules
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "Testing controller now... Put the controller into pairing mode with Share and PS!"
ds4drv --hidraw --led 000008

