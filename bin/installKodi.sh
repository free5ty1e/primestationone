#!/bin/bash

sudo ~/RetroPie-Setup/retropie_packages.sh kodi
# sudo apt-get install kodi-pvr-iptvsimple
mkdir /home/pi/RetroPie/roms/kodi
cp RetroPie/roms/ports/Kodi.sh RetroPie/roms/kodi/

megaInstallKodiWithStreaming.sh
