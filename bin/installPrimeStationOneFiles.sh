#!/bin/bash

echo Installing PrimeStation One main files into their proper locations....
cd ~/primestationone
#sudo mkdir ~/RetroPie/roms/settings
sudo cp -v bin/* /usr/local/bin/
sudo chmod +x /usr/local/bin/*
sudo cp -vr etc /
sudo cp -vr opt /
sudo cp -vr var /
#sudo cp -vr boot /
cp -vr RetroPie/* ~/RetroPie/
chmod +x ~/RetroPie/roms/settings/*.sh
cp -vr .emulationstation/* ~/.emulationstation/
cp -v .* ~/
#cp -v *.gz ~/

echo Removing files that should not be there anymore...
rm ~/RetroPie/roms/settings/install_mega_module_theme_primestationone_emulationstation.sh

#Splashscreen is now taken care of correctly, with the /etc/splashscreen.list file
#cp -v splashscreen.png ~/RetroPie-Setup/supplementary/splashscreens/retropieproject2014/splashscreen.png

cd ~
