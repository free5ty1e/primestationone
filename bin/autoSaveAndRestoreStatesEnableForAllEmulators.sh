#!/bin/bash
echo Enabling auto save and restore states for all emulators...
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"
iniConfig " = " "" "/opt/retropie/configs/all/retroarch.cfg"
iniSet "savestate_auto_save" "true"
iniSet "savestate_auto_load" "true"
ensureRetroarchEmuConfigsIncludesAreLast.sh
