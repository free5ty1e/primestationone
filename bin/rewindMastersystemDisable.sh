#!/bin/bash

message="Disabling Master System emulation rewind feature which may cause massive slowdown just being on..."
echo "$message"
cowsay -f eyes "$message"

source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
iniConfig " = " "" "/opt/retropie/configs/mastersystem/retroarch.cfg"
iniSet "rewind_enable" "false"
iniSet "rewind_buffer_size" "20"
iniSet "rewind_granularity" "2"
