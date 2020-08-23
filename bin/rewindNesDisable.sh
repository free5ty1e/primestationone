#!/bin/bash

message="Disabling NES emulation rewind feature which may cause slowdown just being on..."
echo "$message"
cowsay -f eyes "$message"

source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"
iniConfig " = " "" "/opt/retropie/configs/nes/retroarch.cfg"
iniSet "rewind_enable" "false"
