#!/bin/bash
echo "Setting C64 default emulator..."
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"
iniConfig ' = ' '"' "/opt/retropie/configs/c64/emulators.cfg"

iniSet "default" "lr-vice"
