#!/bin/bash

echo Installing PrimeStation One main files into their proper locations....
cd ~/primestationone
sudo cp -v bin/* /usr/local/bin/
sudo chmod +x /usr/local/bin/*
sudo cp -vr etc /
sudo cp -vr opt /
sudo cp -vr var /
cp -vr RetroPie/* ~/RetroPie/
chmod +x ~/RetroPie/roms/settings/*.sh
cp -vr .emulationstation/* ~/.emulationstation/
cp -v .* ~/

echo Removing c64 emulator profile symlink because we want to put configuration files there and have them in the home/pi/.vice folder...
rm .vice
cp -vr .vice/* ~/*

cd ~
