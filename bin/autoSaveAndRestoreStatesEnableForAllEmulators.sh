#!/bin/bash
echo Setting psx analog controls enabled...
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
iniConfig " = " "" "/opt/retropie/configs/all/retroarch.cfg"
iniSet "savestate_auto_save" "true"
iniSet "savestate_auto_load" "true"
