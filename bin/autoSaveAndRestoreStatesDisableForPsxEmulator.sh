#!/bin/bash
echo Setting psx auto save and restore states disabled...
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"
iniConfig " = " "" "/opt/retropie/configs/psx/retroarch.cfg"
iniSet "savestate_auto_save" "false"
iniSet "savestate_auto_load" "false"
ensureRetroarchEmuConfigsIncludesAreLast.sh
