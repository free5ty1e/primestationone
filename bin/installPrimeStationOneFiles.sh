#!/bin/bash

echo Installing PrimeStation One main files into their proper locations....
pushd ~/primestationone
sudo cp -v bin/* /usr/local/bin/
sudo chmod +x /usr/local/bin/*
sudo cp -vr etc /
#sudo cp -vr opt /
sudo cp -vr var /
sudo cp -v reference/opt/retropie/configs/snes/snesmouse.cfg /opt/retropie/configs/snes/
cp -vr .emulationstation/* ~/.emulationstation/
cp -vr .joymaps ~/
cp -v .* ~/
cp -vr RetroPie/* ~/RetroPie/

echo Ensuring executable bits set on all scripts in roms...
find /home/pi/RetroPie/roms -name '*.sh' -print0 | xargs -0 chmod --verbose 755

echo Resetting permissions on sometimes troublesome folders...
sudo chown pi:pi /home/pi/temp

echo Removing c64 emulator profile symlink because we want to put configuration files there and have them in the home/pi/.vice folder...
rm ~/.vice
mkdir ~/.vice
cp -vr .vice/* ~/.vice/

popd
