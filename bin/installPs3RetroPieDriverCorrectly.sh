#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
fancy_console_message "Installing PS3 driver QtSixAd fork with fake controller support and sixpair from sources..." "bud-frogs"

pushd ~

sudo killall sixpair
sudo rm /usr/sbin/sixpair
sudo killall sixad
sudo RetroPie-Setup/retropie_packages.sh ps3controller remove
sudo apt-get purge -y bluetooth
sudo mkdir -p /var/lib/sixad/profiles
sudo RetroPie-Setup/retropie_packages.sh ps3controller
sudo RetroPie-Setup/retropie_packages.sh ps3controller pair shanwan

#Below is a workaround for allowing both Shanwan and Gasia to work alongside Sony genuine PS3 controllers via bluetooth, this ensures that sixad is actually started
ps3ForceDriverRestartAfterStartup.sh

popd
