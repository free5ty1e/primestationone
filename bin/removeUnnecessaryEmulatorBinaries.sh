#!/bin/bash

cowsay -f vader Eradicating unnecessary emulators...
echo =====================> Eradicating unnecessary emulators...

sudo rm -rf /opt/retropie/emulators/advmame
sudo rm -rf /opt/retropie/emulators/mame4all
sudo rm -rf /opt/retropie/emulators/pifba
sudo rm -rf /opt/retropie/emulators/gngeopi
sudo rm -rf /opt/retropie/emulators/pisnes
sudo apt-get -y autoremove
sudo apt-get clean
