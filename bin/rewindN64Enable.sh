#!/bin/bash

message="Enabling N64 emulation rewind feature which may cause massive slowdown just being on..."
echo "$message"
cowsay -f eyes "$message"

source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
iniConfig " = " "" "/opt/retropie/configs/n64/retroarch.cfg"
iniSet "rewind_enable" "true"
iniSet "rewind_buffer_size" "20"
iniSet "rewind_granularity" "2"
