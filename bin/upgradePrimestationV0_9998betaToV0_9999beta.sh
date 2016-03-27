#!/bin/bash
sudo apt-get -y clean
sudo apt-get -y update
sudo apt-get -y upgrade
quickResetPrimestationOne.sh
installAptRuntimePackages.sh
installMegaTools.sh
rm ~/.megarc
rewindGlobalToggleUnset.sh
rm -rf /opt/retropie/configs/pc
retroPieNukeAndCheckoutFresh.sh
sudo ~/RetroPie-Setup/retropie_packages.sh dosbox
sudo ~/RetroPie-Setup/retropie_packages.sh lr-4do
sudo ~/RetroPie-Setup/retropie_packages.sh lr-beetle-vb
sudo ~/RetroPie-Setup/retropie_packages.sh lr-mgba
sudo ~/RetroPie-Setup/retropie_packages.sh lr-vba-next
sudo ~/RetroPie-Setup/retropie_packages.sh lr-virtualjaguar
sudo ~/RetroPie-Setup/retropie_packages.sh lr-pcsx-rearmed
sudo ~/RetroPie-Setup/retropie_packages.sh lr-yabause
sudo ~/RetroPie-Setup/retropie_packages.sh lr-desmume
sudo ~/RetroPie-Setup/retropie_packages.sh lr-prboom
installSnes9xNextForcedOnPi1.sh
sudo ~/RetroPie-Setup/retropie_packages.sh lr-prosystem
sudo ~/RetroPie-Setup/retropie_packages.sh lr-mupen64plus
sudo ~/RetroPie-Setup/retropie_packages.sh mupen64plus
sudo ~/RetroPie-Setup/retropie_packages.sh mupen64plus-testing
sudo ~/RetroPie-Setup/retropie_packages.sh darkplaces
sudo ~/RetroPie-Setup/retropie_packages.sh kodi
sudo ~/RetroPie-Setup/retropie_packages.sh minecraft
sudo ~/RetroPie-Setup/retropie_packages.sh ags
sudo ~/RetroPie-Setup/retropie_packages.sh openmsx
sudo ~/RetroPie-Setup/retropie_packages.sh dxx-rebirth
sudo ~/RetroPie-Setup/retropie_packages.sh reicast
sudo dpkg --remove qtsixa
sudo ~/RetroPie-Setup/retropie_packages.sh ps3controller
