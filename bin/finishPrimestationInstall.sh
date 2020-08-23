#!/bin/bash

source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

nukeRetroPieSetupRepoAndCheckoutFresh.sh

#Setup all available RetroPie binaries:
sudo ~/RetroPie-Setup/retropie_packages.sh setup binaries

#Fix n64
sudo ~/RetroPie-Setup/retropie_packages.sh lr-mupen64plus install_bin

#Fix Dosbox
sudo ~/RetroPie-Setup/retropie_packages.sh dosbox depends
sudo ~/RetroPie-Setup/retropie_packages.sh dosbox install_bin
sudo ~/RetroPie-Setup/retropie_packages.sh dosbox configure
cp ~/primestationone/reference/opt/retropie/configs/pc/dosbox-SVN.conf /opt/retropie/configs/pc/

#Fix C64
# sudo ~/RetroPie-Setup/retropie_packages.sh vice depends
# sudo ~/RetroPie-Setup/retropie_packages.sh vice install_bin
# rm -rf .vice
# sudo ~/RetroPie-Setup/retropie_packages.sh vice configure
# cp ~/primestationone/reference/opt/retropie/configs/c64/* ~/.vice/

#Fix Mac
sudo ~/RetroPie-Setup/retropie_packages.sh basilisk depends
sudo ~/RetroPie-Setup/retropie_packages.sh basilisk install_bin
sudo ~/RetroPie-Setup/retropie_packages.sh basilisk configure

#Fix Amiga
sudo ~/RetroPie-Setup/retropie_packages.sh uae4arm depends
sudo ~/RetroPie-Setup/retropie_packages.sh uae4arm install_bin
sudo ~/RetroPie-Setup/retropie_packages.sh uae4arm configure

#Fix Apple ][
sudo ~/RetroPie-Setup/retropie_packages.sh linapple depends
sudo ~/RetroPie-Setup/retropie_packages.sh linapple install_bin
sudo ~/RetroPie-Setup/retropie_packages.sh linapple configure

#Install Stratagus / *crafts:
#install Stratagus 2.4 / latest:
sudo ~/RetroPie-Setup/retropie_packages.sh stratagus depends
sudo ~/RetroPie-Setup/retropie_packages.sh stratagus install_bin
sudo ~/RetroPie-Setup/retropie_packages.sh stratagus configure

# #N64 updated libretrocore glupen64!!
# sudo ~/RetroPie-Setup/retropie_packages.sh lr-glupen64 depends
# sudo ~/RetroPie-Setup/retropie_packages.sh lr-glupen64 install_bin
# sudo ~/RetroPie-Setup/retropie_packages.sh lr-glupen64 configure


#Install Doom
sudo ~/RetroPie-Setup/retropie_packages.sh lr-prboom install_bin
sudo ~/RetroPie-Setup/retropie_packages.sh lr-prboom configure

#Install Descent 1 && 2
sudo ~/RetroPie-Setup/retropie_packages.sh dxx-rebirth depends
sudo ~/RetroPie-Setup/retropie_packages.sh dxx-rebirth install_bin
sudo ~/RetroPie-Setup/retropie_packages.sh dxx-rebirth configure
# installDescent1and2.sh
#Reassert latest binaries, maybe?  
#sudo ~/RetroPie-Setup/retropie_packages.sh dxx-rebirth install_bin


#Install ARMSNES
sudo ~/RetroPie-Setup/retropie_packages.sh lr-armsnes install_bin
sudo ~/RetroPie-Setup/retropie_packages.sh lr-armsnes configure

#Install NESTopia
sudo ~/RetroPie-Setup/retropie_packages.sh lr-nestopia install_bin
sudo ~/RetroPie-Setup/retropie_packages.sh lr-nestopia configure


#Built from sources only:
#   Ports
# sudo ~/RetroPie-Setup/retropie_packages.sh residualvm	##Failed last attempt to install on Pi3
# sudo ~/RetroPie-Setup/retropie_packages.sh kodi
# sudo ~/RetroPie-Setup/retropie_packages.sh minecraft
# sudo ~/RetroPie-Setup/retropie_packages.sh giana
# sudo ~/RetroPie-Setup/retropie_packages.sh micropolis
# sudo ~/RetroPie-Setup/retropie_packages.sh solarus
# sudo ~/RetroPie-Setup/retropie_packages.sh supertux
# sudo ~/RetroPie-Setup/retropie_packages.sh uqm
# sudo ~/RetroPie-Setup/retropie_packages.sh ags
# # #sudo ~/RetroPie-Setup/retropie_packages.sh openmsx
# sudo ~/RetroPie-Setup/retropie_packages.sh wolf4sdl
# sudo ~/RetroPie-Setup/retropie_packages.sh xrick
# sudo ~/RetroPie-Setup/retropie_packages.sh zdoom
# sudo ~/RetroPie-Setup/retropie_packages.sh cannonball
# # #sudo ~/RetroPie-Setup/retropie_packages.sh px68k   #Currently fails build on Pi3 so skipping anyway
# sudo ~/RetroPie-Setup/retropie_packages.sh coolcv
# sudo ~/RetroPie-Setup/retropie_packages.sh frotz
# # sudo ~/RetroPie-Setup/retropie_packages.sh stratagus
# sudo ~/RetroPie-Setup/retropie_packages.sh zesarux
# sudo ~/RetroPie-Setup/retropie_packages.sh alephone
# sudo ~/RetroPie-Setup/retropie_packages.sh cgenius
# # sudo ~/RetroPie-Setup/retropie_packages.sh dxx-rebirth
# sudo ~/RetroPie-Setup/retropie_packages.sh gemrb
# sudo ~/RetroPie-Setup/retropie_packages.sh lincity-ng
# sudo ~/RetroPie-Setup/retropie_packages.sh love
# sudo ~/RetroPie-Setup/retropie_packages.sh openbor
# sudo ~/RetroPie-Setup/retropie_packages.sh openttd
# sudo ~/RetroPie-Setup/retropie_packages.sh opentyrian
# sudo ~/RetroPie-Setup/retropie_packages.sh sdlpop
# sudo ~/RetroPie-Setup/retropie_packages.sh tyrquake

# #   Libretrocores:
# sudo ~/RetroPie-Setup/retropie_packages.sh lr-4do
# sudo ~/RetroPie-Setup/retropie_packages.sh lr-beetle-vb
# sudo ~/RetroPie-Setup/retropie_packages.sh lr-beetle-lynx
# sudo ~/RetroPie-Setup/retropie_packages.sh lr-quicknes
# sudo ~/RetroPie-Setup/retropie_packages.sh lr-virtualjaguar
# sudo ~/RetroPie-Setup/retropie_packages.sh lr-yabause
# sudo ~/RetroPie-Setup/retropie_packages.sh lr-beetle-supergrafx
# sudo ~/RetroPie-Setup/retropie_packages.sh lr-desmume
# sudo ~/RetroPie-Setup/retropie_packages.sh lr-gw
# sudo ~/RetroPie-Setup/retropie_packages.sh lr-mame2010
# sudo ~/RetroPie-Setup/retropie_packages.sh lr-mame
# sudo ~/RetroPie-Setup/retropie_packages.sh lr-mess
# sudo ~/RetroPie-Setup/retropie_packages.sh lr-nestopia install_bin

# #   Misc:
# sudo RetroPie-Setup/retropie_packages.sh raspbiantools lxde

# #   Reasserting the playstation1 emulator binaries, as this appears to fix it crashing as of 2016.04.17
# sudo RetroPie-Setup/retropie_packages.sh lr-pcsx-rearmed install_bin

#DREAMCAST:
# #   Reasserting Dreamcast emulator binaries just in case:
sudo RetroPie-Setup/retropie_packages.sh reicast install_bin
sudo RetroPie-Setup/retropie_packages.sh reicast configure
cp -vf ~/primestationone/reference/.reicast/vmu*.bin ~/.reicast/
# #installReicastPrimestationEdition.sh

sudo RetroPie-Setup/retropie_packages.sh redream install_bin
sudo RetroPie-Setup/retropie_packages.sh redream configure


#MAME:
sudo RetroPie-Setup/retropie_packages.sh lr-mame2015
# sudo RetroPie-Setup/retropie_packages.sh lr-mame2015 configure
sudo cleanupTempFiles.sh

#Won't have enough room to compile on 8g card:
# sudo RetroPie-Setup/retropie_packages.sh lr-mame2016
# sudo RetroPie-Setup/retropie_packages.sh lr-mame2016 configure

#sudo cleanupTempFiles.sh

# sudo RetroPie-Setup/retropie_packages.sh lr-mame
# sudo RetroPie-Setup/retropie_packages.sh lr-mame configure


#STEAM LINK
sudo RetroPie-Setup/retropie_packages.sh steamlink
sudo cleanupTempFiles.sh


#TRS-80 COCO:
sudo RetroPie-Setup/retropie_packages.sh xroar
# sudo RetroPie-Setup/retropie_packages.sh xroar configure
sudo cleanupTempFiles.sh


# sudo RetroPie-Setup/retropie_packages.sh emulationstation install_bin

#We probably don't want this USB copyroms service, kill:
# sudo rm /etc/usbmount/mount.d/01_retropie_copyroms 

#   PrimestationPrep:
quickResetPrimestationOne.sh

installMissingPortsFromRetroPieImage.sh

installMegaTools.sh

installKodi.sh
# installNodeVirtualGamepads.sh
installWindowedModeLxde.sh

# installRainbowstream.sh

installPs3RecommendedDriver.sh

#installMpegRecordingCapability.sh
# sudo RetroPie-Setup/retropie_packages.sh retroarch install_bin
# controllerConfigConstruction.sh

setDefaultEmulators.sh

# installDescent1and2.sh

alsamixer

#autoExpandFilesystemNextBoot.sh
