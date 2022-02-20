#!/bin/bash

echo "Installing PrimeStation One main files into their proper locations...."
pushd ~/primestationone
sudo cp -v bin/* /usr/local/bin/
sudo chmod +x /usr/local/bin/*
sudo cp -vr etc /
#sudo cp -vr opt /
sudo cp -vr opt/retropie/configs/all/retroarch-joypads/* /opt/retropie/configs/all/retroarch-joypads/
sudo cp -vr var /
sudo rm -rf /opt/retropie/emulators/openmsx/share/systemroms
sudo ln -s /home/pi/RetroPie/BIOS/msxsystemroms /opt/retropie/emulators/openmsx/share/systemroms
mkdir ~/.xroar
mkdir /home/pi/RetroPie/roms/msxld
mkdir /opt/retropie/configs/msxld
mkdir /home/pi/RetroPie/roms/msxcas
mkdir /opt/retropie/configs/msxcas
mkdir /home/pi/RetroPie/roms/genesismouse
mkdir /opt/retropie/configs/genesismouse
mkdir /home/pi/RetroPie/roms/snesmouse
mkdir /opt/retropie/configs/snesmouse
mkdir /home/pi/RetroPie/roms/supergrafx
mkdir /opt/retropie/configs/supergrafx
mkdir /home/pi/RetroPie/roms/tg16cd
mkdir /opt/retropie/configs/tg16cd

mkdir /home/pi/RetroPie/roms/mame2000
mkdir /opt/retropie/configs/mame2000
mkdir /home/pi/RetroPie/roms/mame2003
mkdir /opt/retropie/configs/mame2003
mkdir /home/pi/RetroPie/roms/mame2010
mkdir /opt/retropie/configs/mame2010
mkdir /home/pi/RetroPie/roms/mame2015
mkdir /opt/retropie/configs/mame2015
mkdir /home/pi/RetroPie/roms/mame2016
mkdir /opt/retropie/configs/mame2016

cp -v reference/opt/retropie/configs/snesmouse/*.cfg /opt/retropie/configs/snesmouse/
cp --verbose reference/opt/retropie/configs/msxld/*.cfg /opt/retropie/configs/msxld/
cp --verbose reference/opt/retropie/configs/msxcas/*.cfg /opt/retropie/configs/msxcas/
cp --verbose reference/opt/retropie/configs/genesismouse/*.cfg /opt/retropie/configs/genesismouse/
cp --verbose reference/opt/retropie/configs/supergrafx/*.cfg /opt/retropie/configs/supergrafx/
cp --verbose reference/opt/retropie/configs/tg16cd/*.cfg /opt/retropie/configs/tg16cd/

cp --verbose reference/opt/retropie/configs/mame2000/*.cfg /opt/retropie/configs/mame2000/
cp --verbose reference/opt/retropie/configs/mame2003/*.cfg /opt/retropie/configs/mame2003/
cp --verbose reference/opt/retropie/configs/mame2010/*.cfg /opt/retropie/configs/mame2010/
cp --verbose reference/opt/retropie/configs/mame2015/*.cfg /opt/retropie/configs/mame2015/
cp --verbose reference/opt/retropie/configs/mame2016/*.cfg /opt/retropie/configs/mame2016/

cp -v reference/opt/retropie/configs/all/retronetplay.cfg /opt/retropie/configs/all/
cp -v reference/opt/retropie/configs/atari5200/*.cfg /opt/retropie/configs/atari5200/
cp -vr .emulationstation/* ~/.emulationstation/
cp -vr .kodi/* ~/.kodi/
cp -vr .reicast/* ~/.reicast/
cp -vr .joymaps ~/
cp -v .* ~/
mkdir -p ~/RetroPie/roms/mame/mame2003/cfg
cp -vr RetroPie/* ~/RetroPie/
cp -vr reference/.atari800.cfg ~/
cp -vr ~/RetroPie/BIOS/dc_*.bin ~/RetroPie/BIOS/dc/
ln --symbolic /opt/retropie/configs/coco/xroar.conf ~/.xroar/xroar.conf
cp -vr reference/config/vice/* ~/.config/vice/

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
