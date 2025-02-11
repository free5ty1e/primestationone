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

sudo mkdir --parents /opt/retropie/configs/ports/descent1
sudo mkdir --parents /opt/retropie/configs/ports/descent2

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

sudo cp --verbose reference/opt/retropie/configs/ports/descent1/* /opt/retropie/configs/ports/descent1/
sudo cp --verbose reference/opt/retropie/configs/ports/descent2/* /opt/retropie/configs/ports/descent2/

echo "Installing snes 9x 2010 mouse remap file"
sudo mkdir -v "/opt/retropie/configs/snes/Snes9x 2010"
sudo cp --verbose "reference/opt/retropie/configs/snes/Snes9x 2010/snesmouse.rmp" "/opt/retropie/configs/snes/Snes9x 2010/"

echo "Installing emulator-specific core remap files to fix things like A and B as circle and X on the PS3 controller (should be X and Square)..."
echo "The core info files can be found at /opt/retropie/configs/all/retroarch/cores/ to determine the corename / filename for each remap file..."
echo "Cores named Beetle are actually rebrands of mednafen, so those files begin with mednafen and not beetle."
echo "First, ensuring all configs are owned by pi..."
sudo chown --verbose --recursive pi:pi /opt/retropie/configs

echo "FIRST - remapping 2 button emus that use Circle for jump and Cross for fire, to use Cross for jump and Square for fire..."
echo "Remapping NES cores..."
mkdir -vp "/opt/retropie/configs/nes/FCEUmm"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/nes/FCEUmm/FCEUmm.rmp"
mkdir -vp "/opt/retropie/configs/nes/Nestopia"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/nes/Nestopia/Nestopia.rmp"
mkdir -vp "/opt/retropie/configs/nes/QuickNES"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/nes/QuickNES/QuickNES.rmp"
mkdir -vp "/opt/retropie/configs/nes/Mesen"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/nes/Mesen/Mesen.rmp"
mkdir -vp "/opt/retropie/configs/nes/FinalBurn Neo"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/nes/FinalBurn Neo/FinalBurn Neo.rmp"
echo "Remapping Nintendo GameBoy cores..."
mkdir -vp "/opt/retropie/configs/gb/Gambatte"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/gb/Gambatte/Gambatte.rmp"
mkdir -vp "/opt/retropie/configs/gb/mGBA"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/gb/mGBA/mGBA.rmp"
mkdir -vp "/opt/retropie/configs/gb/TGB Dual"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/gb/TGB Dual/TGB Dual.rmp"
echo "Remapping Nintendo GameBoy Color cores..."
mkdir -vp "/opt/retropie/configs/gbc/Gambatte"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/gbc/Gambatte/Gambatte.rmp"
mkdir -vp "/opt/retropie/configs/gbc/mGBA"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/gbc/mGBA/mGBA.rmp"
mkdir -vp "/opt/retropie/configs/gbc/TGB Dual"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/gbc/TGB Dual/TGB Dual.rmp"
echo "Remapping Nintendo GameBoy Advance cores..."
mkdir -vp "/opt/retropie/configs/gba/mGBA"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/gba/mGBA/mGBA.rmp"
mkdir -vp "/opt/retropie/configs/gba/gpSP"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/gba/gpSP/gpSP.rmp"
mkdir -vp "/opt/retropie/configs/gba/VBA Next"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/gba/VBA Next/VBA Next.rmp"
echo "Remapping TurboGrafx 16 (PC Engine) cores..."
mkdir -vp "/opt/retropie/configs/pcengine/FinalBurn Neo"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/pcengine/FinalBurn Neo/FinalBurn Neo.rmp"
mkdir -vp "/opt/retropie/configs/pcengine/Beetle SuperGrafx"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/pcengine/Beetle SuperGrafx/Beetle SuperGrafx.rmp"
mkdir -vp "/opt/retropie/configs/pcengine/Beetle PCE Fast"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/pcengine/Beetle PCE Fast/Beetle PCE Fast.rmp"
mkdir -vp "/opt/retropie/configs/pcengine/Beetle PCE"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/pcengine/Beetle PCE/Beetle PCE.rmp"
echo "Remapping SuprGrafx cores..."
mkdir -vp "/opt/retropie/configs/supergrafx/Beetle SuperGrafx"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/supergrafx/Beetle SuperGrafx/Beetle SuperGrafx.rmp"
echo "Remapping Sega Game Gear cores..."
mkdir -vp "/opt/retropie/configs/gamegear/FinalBurn Neo"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/gamegear/FinalBurn Neo/FinalBurn Neo.rmp"
mkdir -vp "/opt/retropie/configs/gamegear/Genesis Plus GX"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/gamegear/Genesis Plus GX/Genesis Plus GX.rmp"
mkdir -vp "/opt/retropie/configs/gamegear/Gearsystem"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/gamegear/Gearsystem/Gearsystem.rmp"
mkdir -vp "/opt/retropie/configs/gamegear/SMS Plus GX"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/gamegear/SMS Plus GX/SMS Plus GX.rmp"
echo "Remapping Neo Geo Pocket cores..."
mkdir -vp "/opt/retropie/configs/ngp/Beetle NeoPop"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/ngp/Beetle NeoPop/Beetle NeoPop.rmp"
mkdir -vp "/opt/retropie/configs/ngp/FinalBurn Neo"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/ngp/FinalBurn Neo/FinalBurn Neo.rmp"
echo "Remapping Neo Geo Pocket Color cores..."
mkdir -vp "/opt/retropie/configs/ngpc/Beetle NeoPop"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/ngpc/Beetle NeoPop/Beetle NeoPop.rmp"
mkdir -vp "/opt/retropie/configs/ngpc/FinalBurn Neo"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/ngpc/FinalBurn Neo/FinalBurn Neo.rmp"
echo "Remapping MAME cores..."
mkdir -vp "/opt/retropie/configs/mame-libretro/MAME 2000"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/mame-libretro/MAME 2000/MAME 2000.rmp"
mkdir -vp "/opt/retropie/configs/mame-libretro/MAME 2003"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/mame-libretro/MAME 2003/MAME 2003.rmp"
mkdir -vp "/opt/retropie/configs/mame-libretro/MAME 2003-PLUS"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/mame-libretro/MAME 2003-PLUS/MAME 2003-PLUS.rmp"
mkdir -vp "/opt/retropie/configs/mame-libretro/MAME 2010"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/mame-libretro/MAME 2010/MAME 2010.rmp"
mkdir -vp "/opt/retropie/configs/mame-libretro/MAME 2015"
cp --verbose "reference/opt/retropie/configs/all/2buttonNesEmulatorRemap.rmp" "/opt/retropie/configs/mame-libretro/MAME 2015/MAME 2015.rmp"

echo "SECOND - remapping other 2 button emus that use reversed Circle for fire and Cross for jump, to use Cross for jump and Square for fire..."
echo "Remapping Sega SG-1000 cores..."
mkdir -vp "/opt/retropie/configs/sg-1000/FinalBurn Neo"
cp --verbose "reference/opt/retropie/configs/all/2buttonSmsReverseEmulatorRemap.rmp" "/opt/retropie/configs/sg-1000/FinalBurn Neo/FinalBurn Neo.rmp"
mkdir -vp "/opt/retropie/configs/sg-1000/Gearsystem"
cp --verbose "reference/opt/retropie/configs/all/2buttonSmsReverseEmulatorRemap.rmp" "/opt/retropie/configs/sg-1000/Gearsystem/Gearsystem.rmp"
mkdir -vp "/opt/retropie/configs/sg-1000/Genesis Plus GX"
cp --verbose "reference/opt/retropie/configs/all/2buttonSmsReverseEmulatorRemap.rmp" "/opt/retropie/configs/sg-1000/Genesis Plus GX/Genesis Plus GX.rmp"
echo "Remapping Sega Master System cores..."
mkdir -vp "/opt/retropie/configs/mastersystem/SMS Plus GX"
cp --verbose "reference/opt/retropie/configs/all/2buttonSmsReverseEmulatorRemap.rmp" "/opt/retropie/configs/mastersystem/SMS Plus GX/SMS Plus GX.rmp"
mkdir -vp "/opt/retropie/configs/mastersystem/Gearsystem"
cp --verbose "reference/opt/retropie/configs/all/2buttonSmsReverseEmulatorRemap.rmp" "/opt/retropie/configs/mastersystem/Gearsystem/Gearsystem.rmp"
mkdir -vp "/opt/retropie/configs/mastersystem/FinalBurn Neo"
cp --verbose "reference/opt/retropie/configs/all/2buttonSmsReverseEmulatorRemap.rmp" "/opt/retropie/configs/mastersystem/FinalBurn Neo/FinalBurn Neo.rmp"
mkdir -vp "/opt/retropie/configs/mastersystem/Genesis Plus GX"
cp --verbose "reference/opt/retropie/configs/all/2buttonSmsReverseEmulatorRemap.rmp" "/opt/retropie/configs/mastersystem/Genesis Plus GX/Genesis Plus GX.rmp"
mkdir -vp "/opt/retropie/configs/mastersystem/PicoDrive"
cp --verbose "reference/opt/retropie/configs/all/2buttonSmsReverseEmulatorRemap.rmp" "/opt/retropie/configs/mastersystem/PicoDrive/PicoDrive.rmp"
echo "Remapping MSX cores..."
mkdir -vp "/opt/retropie/configs/msx/FinalBurn Neo"
cp --verbose "reference/opt/retropie/configs/all/2buttonSmsReverseEmulatorRemap.rmp" "/opt/retropie/configs/msx/FinalBurn Neo/FinalBurn Neo.rmp"
mkdir -vp "/opt/retropie/configs/msx/fMSX"
cp --verbose "reference/opt/retropie/configs/all/2buttonSmsReverseEmulatorRemap.rmp" "/opt/retropie/configs/msx/fMSX/fMSX.rmp"
mkdir -vp "/opt/retropie/configs/msx/blueMSX"
cp --verbose "reference/opt/retropie/configs/all/2buttonSmsReverseEmulatorRemap.rmp" "/opt/retropie/configs/msx/blueMSX/blueMSX.rmp"
echo "Remapping Atari Lynx cores..."
mkdir -vp "/opt/retropie/configs/atarilynx/Handy"
cp --verbose "reference/opt/retropie/configs/all/2buttonSmsReverseEmulatorRemap.rmp" "/opt/retropie/configs/atarilynx/Handy/Handy.rmp"
mkdir -vp "/opt/retropie/configs/atarilynx/Beetle Lynx"
cp --verbose "reference/opt/retropie/configs/all/2buttonSmsReverseEmulatorRemap.rmp" "/opt/retropie/configs/atarilynx/Beetle Lynx/Beetle Lynx.rmp"
echo "Remapping Wonderswan cores..."
mkdir -vp "/opt/retropie/configs/wonderswan/Beetle WonderSwan"
cp --verbose "reference/opt/retropie/configs/all/2buttonSmsReverseEmulatorRemap.rmp" "/opt/retropie/configs/wonderswan/Beetle WonderSwan/Beetle WonderSwan.rmp"
echo "Remapping Wonderswan Color cores..."
mkdir -vp "/opt/retropie/configs/wonderswancolor/Beetle WonderSwan"
cp --verbose "reference/opt/retropie/configs/all/2buttonSmsReverseEmulatorRemap.rmp" "/opt/retropie/configs/wonderswancolor/Beetle WonderSwan/Beetle WonderSwan.rmp"


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
