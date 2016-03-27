#!/bin/bash
echo Setting psx auto save and restore states enabled...
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"
iniConfig " = " "" "/opt/retropie/configs/psx/retroarch.cfg"
iniSet "savestate_auto_save" "true"
iniSet "savestate_auto_load" "true"
ensureRetroarchEmuConfigsIncludesAreLast.sh
