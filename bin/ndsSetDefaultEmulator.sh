#!/bin/bash
echo "Setting Nintendo DS default emulator..."
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"
iniConfig ' = ' '"' "/opt/retropie/configs/nds/emulators.cfg"

iniSet "default" "lr-desmume"
