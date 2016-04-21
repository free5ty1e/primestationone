#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
fancy_console_message "Installing PS3 driver QtSixAd fork with fake controller support and sixpair from sources..." "bud-frogs"

sudo killall sixpair
sudo rm /usr/sbin/sixpair
sudo killall sixad
sudo RetroPie-Setup/retropie_packages.sh ps3controller remove
sudo mkdir -p /var/lib/sixad/profiles
sudo RetroPie-Setup/retropie_packages.sh ps3controller pair shanwan
