#!/bin/bash

cowsay -f vader Eradicating unnecessary emulators...
echo Eradicating unnecessary emulators...


sudo rm -rf /opt/retropie/emulators/pisnes
sudo rm -rf /opt/retropie/emulators/snes9x
sudo rm -rf /opt/retropie/emulators/mupen64plus
sudo rm -rf /opt/retropie/emulators/osmose
sudo rm -rf /opt/retropie/emulators/dgen
#stella, wherever dafuq it is
sudo rm -rf /opt/retropie/emulators/pifba
sudo rm -rf /opt/retropie/emulators/gngeopi
sudo rm -rf /opt/retropie/emulators/advmame
sudo rm -rf /opt/retropie/emulators/mame4all
sudo apt-get -y autoremove
sudo apt-get clean
