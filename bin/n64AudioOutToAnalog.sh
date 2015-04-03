#!/bin/bash
echo MUST BE RUN AS ROOT - Setting mupen64plus non-libretrocore emulators to output audio to the Analog 3.5mm jack
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
iniSet "OUTPUT_PORT" “0” "/opt/retropie/configs/n64/mupen64plus.cfg" >/dev/null
