#!/bin/bash

cd ~/primestationone
sudo chmod +x bin/*
#sudo mkdir ~/RetroPie/roms/settings
sudo chmod +x RetroPie/roms/settings/*.sh
sudo cp -v bin/* /usr/local/bin/
sudo cp -vr etc /
sudo cp -vr opt /
sudo cp -vr var /
#sudo cp -vr boot /
sudo cp -vr RetroPie/* ~/RetroPie/
sudo cp -vr .emulationstation/* ~/.emulationstation/
sudo cp -v .* ~/
#cp -v *.gz ~/

#Splashscreen is now taken care of correctly, with the /etc/splashscreen.list file
#cp -v splashscreen.png ~/RetroPie-Setup/supplementary/splashscreens/retropieproject2014/splashscreen.png

cd ~
