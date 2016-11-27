#!/bin/bash

echo "Installing PrimeStation One main files into their proper locations...."
pushd ~/primestationone
sudo cp -v bin/* /usr/local/bin/
sudo chmod +x /usr/local/bin/*
sudo cp -vr etc /
#sudo cp -vr opt /
sudo cp -vr opt/retropie/configs/all/retroarch-joypads/* /opt/retropie/configs/all/retroarch-joypads/
sudo cp -vr var /
mkdir /opt/retropie/configs/snesmouse
cp -v reference/opt/retropie/configs/snesmouse/*.cfg /opt/retropie/configs/snesmouse/
cp -vr .emulationstation/* ~/.emulationstation/
cp -vr .kodi/* ~/.kodi/
cp -vr .joymaps ~/
cp -v .* ~/
cp -vr RetroPie/* ~/RetroPie/

echo "Ensuring executable bits set on all scripts in roms..."
find /home/pi/RetroPie/roms -name '*.sh' -print0 | xargs -0 chmod --verbose 755

echo "Fixing permissions on your home and local folders just in case!"
sudo chown pi:pi /home/pi/temp
sudo chown -R pi ~
sudo chown -R pi /usr/local

# echo "Installing auto-expand check script..."
# sudo cp -fv /home/pi/primestationone/bin/fsExpandCheck_jessie.sh /etc/init.d/
# sudo chmod +x /etc/init.d/fsExpandCheck_jessie.sh
# sudo update-rc.d fsExpandCheck_jessie.sh defaults
# sudo rm /boot/NOCHECKUPDATE

# echo "Removing c64 emulator profile symlink because we want to put configuration files there and have them in the home/pi/.vice folder..."
# rm ~/.vice
# mkdir ~/.vice
# cp -vr .vice/* ~/.vice/

popd
