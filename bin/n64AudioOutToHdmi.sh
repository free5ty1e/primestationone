#!/bin/bash
echo MUST BE RUN AS ROOT - Setting mupen64plus non-libretrocore emulators to output audio to the HDMI cable
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
iniConfig " = " "" "/opt/retropie/configs/n64/mupen64plus.cfg"
iniSet "OUTPUT_PORT" “1”
