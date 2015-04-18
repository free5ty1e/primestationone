#!/bin/bash

message="Disabling global emulation rewind feature which may cause massive slowdown just being on for certain games and emus..."
echo "$message"
cowsay -f eyes "$message"

source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
iniConfig " = " "" "/opt/retropie/configs/all/retroarch.cfg"
iniSet "rewind_enable" "true"
