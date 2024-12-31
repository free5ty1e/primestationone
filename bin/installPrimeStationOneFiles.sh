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
sudo ln -sv /home/pi/RetroPie/BIOS/msxsystemroms /opt/retropie/emulators/openmsx/share/systemroms

echo "Linking retroarch-joypads folder so joy2key can find configs..."
sudo ln -sv /opt/retropie/configs/all/retroarch/autoconfig /opt/retropie/configs/all/retroarch-joypads


echo "Checking if PSP emulator PPSSPP has savedata linked properly to retropie roms folder, if not will migrate and link..."
if [[ -L "/opt/retropie/configs/psp/PSP/SAVEDATA" ]]; then
  echo "/opt/retropie/configs/psp/PSP/SAVEDATA is already a link!  No need to migrate or link..."
else
  echo "/opt/retropie/configs/psp/PSP/SAVEDATA is not a link!!  Need to migrate to retropie roms/psp/SAVEDATA folder and link..."
  cp -rfv /opt/retropie/configs/psp/PSP/SAVEDATA/* /home/pi/RetroPie/roms/psp/SAVEDATA/
  rm -rf /opt/retropie/configs/psp/PSP/SAVEDATA
  sudo ln -sv /home/pi/RetroPie/roms/psp/SAVEDATA /opt/retropie/configs/psp/PSP/SAVEDATA
fi

echo "Checking if PSP emulator PPSSPP has savestate data linked properly to retropie roms folder, if not will migrate and link..."
if [[ -L "/opt/retropie/configs/psp/PSP/PPSSPP_STATE" ]]; then
  echo "/opt/retropie/configs/psp/PSP/PPSSPP_STATE is already a link!  No need to migrate or link..."
else
  echo "/opt/retropie/configs/psp/PSP/PPSSPP_STATE is not a link!!  Need to migrate to retropie roms/psp/PPSSPP_STATE folder and link..."
  cp -rfv /opt/retropie/configs/psp/PSP/PPSSPP_STATE/* /home/pi/RetroPie/roms/psp/PPSSPP_STATE/
  rm -rf /opt/retropie/configs/psp/PSP/PPSSPP_STATE
  sudo ln -sv /home/pi/RetroPie/roms/psp/PPSSPP_STATE /opt/retropie/configs/psp/PSP/PPSSPP_STATE
fi

mkdir ~/.xroar
cp --verbose reference/xroar/* ~/.xroar/
mkdir /home/pi/RetroPie/roms/msxld
sudo mkdir /opt/retropie/configs/msxld
mkdir /home/pi/RetroPie/roms/msxcas
sudo mkdir /opt/retropie/configs/msxcas
mkdir /home/pi/RetroPie/roms/genesismouse
sudo mkdir /opt/retropie/configs/genesismouse
mkdir /home/pi/RetroPie/roms/snesmouse
sudo mkdir /opt/retropie/configs/snesmouse
mkdir /home/pi/RetroPie/roms/supergrafx
sudo mkdir /opt/retropie/configs/supergrafx
mkdir /home/pi/RetroPie/roms/tg16cd
sudo mkdir /opt/retropie/configs/tg16cd

mkdir /home/pi/RetroPie/roms/mame2000
sudo mkdir /opt/retropie/configs/mame2000
mkdir /home/pi/RetroPie/roms/mame2003
sudo mkdir /opt/retropie/configs/mame2003
mkdir /home/pi/RetroPie/roms/mame2010
sudo mkdir /opt/retropie/configs/mame2010
mkdir /home/pi/RetroPie/roms/mame2015
sudo mkdir /opt/retropie/configs/mame2015
mkdir /home/pi/RetroPie/roms/mame2016
sudo mkdir /opt/retropie/configs/mame2016

sudo cp -v reference/opt/retropie/configs/snesmouse/*.cfg /opt/retropie/configs/snesmouse/
sudo cp --verbose reference/opt/retropie/configs/msxld/*.cfg /opt/retropie/configs/msxld/
sudo cp --verbose reference/opt/retropie/configs/msxcas/*.cfg /opt/retropie/configs/msxcas/
sudo cp --verbose reference/opt/retropie/configs/genesismouse/*.cfg /opt/retropie/configs/genesismouse/
sudo cp --verbose reference/opt/retropie/configs/supergrafx/*.cfg /opt/retropie/configs/supergrafx/
sudo cp --verbose reference/opt/retropie/configs/tg16cd/*.cfg /opt/retropie/configs/tg16cd/

sudo cp --verbose reference/opt/retropie/configs/mame2000/*.cfg /opt/retropie/configs/mame2000/
sudo cp --verbose reference/opt/retropie/configs/mame2003/*.cfg /opt/retropie/configs/mame2003/
sudo cp --verbose reference/opt/retropie/configs/mame2010/*.cfg /opt/retropie/configs/mame2010/
sudo cp --verbose reference/opt/retropie/configs/mame2015/*.cfg /opt/retropie/configs/mame2015/
sudo cp --verbose reference/opt/retropie/configs/mame2016/*.cfg /opt/retropie/configs/mame2016/

echo "Installing snes 9x 2010 mouse remap file"
sudo mkdir -v "/opt/retropie/configs/snes/Snes9x 2010"
sudo cp --verbose "reference/opt/retropie/configs/snes/Snes9x 2010/snesmouse.rmp" "/opt/retropie/configs/snes/Snes9x 2010/"

echo "Installing emulator-specific core remap files to fix things like A and B as circle and X on the PS3 controller (should be X and Square)..."
echo "Fixing NES..."
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/nes/FCEUmm/FCEUmm.rmp"


sudo cp -v reference/opt/retropie/configs/all/retronetplay.cfg /opt/retropie/configs/all/
sudo cp -v reference/opt/retropie/configs/atari5200/*.cfg /opt/retropie/configs/atari5200/
cp -vr .emulationstation/* ~/.emulationstation/
cp -vr .kodi/* ~/.kodi/
cp -vr .reicast/* ~/.reicast/
cp -vr .joymaps ~/
cp -v .* ~/
mkdir -p ~/RetroPie/roms/mame/mame2003/cfg
cp -vr RetroPie/* ~/RetroPie/
cp -vr reference/.atari800.cfg ~/
cp -vr ~/RetroPie/BIOS/dc_*.bin ~/RetroPie/BIOS/dc/
#ln --symbolic /opt/retropie/configs/coco/xroar.conf ~/.xroar/xroar.conf
cp -vr reference/config/vice/* ~/.config/vice/
mkdir  ~/.config/ds4drv
cp -vr reference/.config/ds4drv/* ~/.config/ds4drv/

#reference\primestation-joypad-autoconfigs\ds4drv
sudo cp -vr reference/primestation-joypad-autoconfigs/ds4drv/* /opt/retropie/configs/all/retroarch/autoconfig/
sudo cp -vr reference/primestation-joypad-autoconfigs/ds4drv/* /opt/retropie/configs/all/retroarch/autoconfig/udev/


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
