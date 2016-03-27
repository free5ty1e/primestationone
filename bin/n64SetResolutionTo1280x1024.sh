#!/bin/bash
echo Setting mupen64plus video resolution to 1280x1024
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"
iniConfig " = " "" "/opt/retropie/configs/n64/mupen64plus.cfg"
iniSet "ScreenWidth" 1280
iniSet "ScreenHeight" 1024
