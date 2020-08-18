#!/bin/bash
echo "Setting DOS default emulator..."
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"
iniConfig ' = ' '"' "/opt/retropie/configs/dos/emulators.cfg"

iniSet "default" "dosbox-sdl2"
