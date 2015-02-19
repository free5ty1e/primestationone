#!/bin/bash

user="$SUDO_USER"
sudo sed /etc/inittab -i -e "s|1:2345:respawn:/sbin/getty --noclear 38400 tty1|1:2345:respawn:\/bin\/login -f pi tty1 \<\/dev\/tty1 \>\/dev\/tty1 2\>\&1|g"
sudo update-rc.d lightdm disable 2 # taken from /usr/bin/raspi-config
if ! egrep -i -q "emulationstation$" /etc/profile; then
    echo "[ -n \"\${SSH_CONNECTION}\" ] || emulationstation" >> /etc/profile
fi
