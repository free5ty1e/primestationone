#!/bin/bash

cd ~/primestationone
sudo chmod +x bin/*
sudo chmod +x RetroPie/roms/settings/*.sh
sudo cp -v bin/* /usr/bin/
sudo cp -vr etc /
sudo cp -vr opt /
sudo cp -vr var /
sudo cp -vr boot /
cp -vr RetroPie/* ~/RetroPie/
cp -vr .emulationstation/* ~/.emulationstation/
cp -v .* ~/
#cp -v *.gz ~/
cp -v splashscreen.png ~/RetroPie-Setup/supplementary/splashscreens/retropieproject2014/splashscreen.png
cd ~
