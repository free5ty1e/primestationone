#!/bin/bash
echo "Setting DOS PS3 controls..."
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"
iniConfig '=' '' '/opt/retropie/configs/pc/dosbox-sdl2-SVN.conf'

## Fix joystick scanning
iniSet "timed" "false"
