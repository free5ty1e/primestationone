#!/bin/bash

#PrimestationPrep:
quickResetPrimestationOne.sh
installMegaTools.sh
installReicastPrimestationEdition.sh
installDescent1and2.sh

#Ports:
sudo ~/RetroPie-Setup/retropie_packages.sh darkplaces
sudo ~/RetroPie-Setup/retropie_packages.sh kodi
sudo ~/RetroPie-Setup/retropie_packages.sh minecraft
sudo ~/RetroPie-Setup/retropie_packages.sh giana
sudo ~/RetroPie-Setup/retropie_packages.sh micropolis
sudo ~/RetroPie-Setup/retropie_packages.sh solarus
sudo ~/RetroPie-Setup/retropie_packages.sh supertux
sudo ~/RetroPie-Setup/retropie_packages.sh uqm
sudo ~/RetroPie-Setup/retropie_packages.sh ags
sudo ~/RetroPie-Setup/retropie_packages.sh openmsx
sudo ~/RetroPie-Setup/retropie_packages.sh yabause
sudo ~/RetroPie-Setup/retropie_packages.sh wolf4sdl
sudo ~/RetroPie-Setup/retropie_packages.sh xrick
sudo ~/RetroPie-Setup/retropie_packages.sh zdoom
sudo ~/RetroPie-Setup/retropie_packages.sh cannonball

#Libretrocores:
sudo ~/RetroPie-Setup/retropie_packages.sh lr-4do
sudo ~/RetroPie-Setup/retropie_packages.sh lr-beetle-vb
sudo ~/RetroPie-Setup/retropie_packages.sh lr-vba-next
sudo ~/RetroPie-Setup/retropie_packages.sh lr-ppsspp
sudo ~/RetroPie-Setup/retropie_packages.sh lr-handy
sudo ~/RetroPie-Setup/retropie_packages.sh lr-virtualjaguar
sudo ~/RetroPie-Setup/retropie_packages.sh lr-yabause
sudo ~/RetroPie-Setup/retropie_packages.sh lr-imame4all
sudo ~/RetroPie-Setup/retropie_packages.sh lr-mame2003
sudo ~/RetroPie-Setup/retropie_packages.sh lr-mame2010
sudo ~/RetroPie-Setup/retropie_packages.sh lr-mame
sudo ~/RetroPie-Setup/retropie_packages.sh lr-nxengine
sudo ~/RetroPie-Setup/retropie_packages.sh lr-o2em
sudo ~/RetroPie-Setup/retropie_packages.sh lr-pcsx-rearmed
sudo ~/RetroPie-Setup/retropie_packages.sh lr-prosystem
sudo ~/RetroPie-Setup/retropie_packages.sh lr-quicknes

#TODO: Windowed mode / LXDE

#TODO: Fix qtsixa Primestation edition universal driver instead of using this:
installPs3SonyOnlyDriver.sh
