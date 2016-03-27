#!/bin/bash
echo Setting mupen64plus non-libretrocore emulators to output audio to the Analog 3.5mm jack
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"
iniConfig " = " "" "/opt/retropie/configs/n64/mupen64plus.cfg"
iniSet "OUTPUT_PORT" 0
