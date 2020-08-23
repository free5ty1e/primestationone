#!/bin/bash
echo "Setting Dreamcast default emulator..."
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"
iniConfig ' = ' '"' "/opt/retropie/configs/dreamcast/emulators.cfg"

iniSet "default" "redream"
