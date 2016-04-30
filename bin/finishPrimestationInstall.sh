#!/bin/bash

#Setup all available RetroPie binaries:
sudo ~/RetroPie-Setup/retropie_packages.sh setup binaries

#Built from sources only:
#   Ports
sudo ~/RetroPie-Setup/retropie_packages.sh kodi
sudo ~/RetroPie-Setup/retropie_packages.sh minecraft
sudo ~/RetroPie-Setup/retropie_packages.sh giana
sudo ~/RetroPie-Setup/retropie_packages.sh micropolis
sudo ~/RetroPie-Setup/retropie_packages.sh solarus
sudo ~/RetroPie-Setup/retropie_packages.sh supertux
sudo ~/RetroPie-Setup/retropie_packages.sh uqm
sudo ~/RetroPie-Setup/retropie_packages.sh ags
#sudo ~/RetroPie-Setup/retropie_packages.sh openmsx
sudo ~/RetroPie-Setup/retropie_packages.sh wolf4sdl
sudo ~/RetroPie-Setup/retropie_packages.sh xrick
sudo ~/RetroPie-Setup/retropie_packages.sh zdoom
sudo ~/RetroPie-Setup/retropie_packages.sh cannonball
sudo ~/RetroPie-Setup/retropie_packages.sh px68k
sudo ~/RetroPie-Setup/retropie_packages.sh coolcv
sudo ~/RetroPie-Setup/retropie_packages.sh frotz
sudo ~/RetroPie-Setup/retropie_packages.sh residualvm
sudo ~/RetroPie-Setup/retropie_packages.sh stratagus
sudo ~/RetroPie-Setup/retropie_packages.sh zesarux
sudo ~/RetroPie-Setup/retropie_packages.sh alephone
sudo ~/RetroPie-Setup/retropie_packages.sh cgenius
sudo ~/RetroPie-Setup/retropie_packages.sh dxx-rebirth
sudo ~/RetroPie-Setup/retropie_packages.sh gemrb
sudo ~/RetroPie-Setup/retropie_packages.sh lincity-ng
sudo ~/RetroPie-Setup/retropie_packages.sh love
sudo ~/RetroPie-Setup/retropie_packages.sh openbor
sudo ~/RetroPie-Setup/retropie_packages.sh openttd
sudo ~/RetroPie-Setup/retropie_packages.sh opentyrian
sudo ~/RetroPie-Setup/retropie_packages.sh sdlpop
sudo ~/RetroPie-Setup/retropie_packages.sh tyrquake
sudo ~/RetroPie-Setup/retropie_packages.sh uqm
sudo ~/RetroPie-Setup/retropie_packages.sh zdoom

#   Libretrocores:
sudo ~/RetroPie-Setup/retropie_packages.sh lr-4do
sudo ~/RetroPie-Setup/retropie_packages.sh lr-beetle-vb
sudo ~/RetroPie-Setup/retropie_packages.sh lr-beetle-lynx
sudo ~/RetroPie-Setup/retropie_packages.sh lr-quicknes
sudo ~/RetroPie-Setup/retropie_packages.sh lr-virtualjaguar
sudo ~/RetroPie-Setup/retropie_packages.sh lr-yabause
sudo ~/RetroPie-Setup/retropie_packages.sh lr-beetle-supergrafx
sudo ~/RetroPie-Setup/retropie_packages.sh lr-desmume
sudo ~/RetroPie-Setup/retropie_packages.sh lr-gw
sudo ~/RetroPie-Setup/retropie_packages.sh lr-mame2010
sudo ~/RetroPie-Setup/retropie_packages.sh lr-mame
sudo ~/RetroPie-Setup/retropie_packages.sh lr-mess
sudo ~/RetroPie-Setup/retropie_packages.sh lr-nestopia install_bin

#   Misc:
sudo RetroPie-Setup/retropie_packages.sh raspbiantools lxde

#   Reasserting the playstation1 emulator binaries, as this appears to fix it crashing as of 2016.04.17
sudo RetroPie-Setup/retropie_packages.sh lr-pcsx-rearmed install_bin

#   Reasserting Dreamcast emulator binaries just in case:
sudo RetroPie-Setup/retropie_packages.sh reicast install_bin
#installReicastPrimestationEdition.sh

#   PrimestationPrep:
quickResetPrimestationOne.sh
installMegaTools.sh
#installWindowedModeLxde.sh

#installRainbowstream.sh

#installMpegRecordingCapability.sh
sudo RetroPie-Setup/retropie_packages.sh retroarch install_bin
controllerConfigConstruction.sh


#installDescent1and2.sh

installAptRuntimePackages.sh
sudo apt-get -y purge wicd-curses
installPs3RecommendedDriver.sh

alsamixer

#autoExpandFilesystemNextBoot.sh
