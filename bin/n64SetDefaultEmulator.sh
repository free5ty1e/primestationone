#!/bin/bash
echo "Setting N64 default emulator..."
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"
iniConfig " = " "" "/opt/retropie/configs/n64/emulators.cfg"


iniSet "default" "\"lr-glupen64\""
