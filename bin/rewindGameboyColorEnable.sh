#!/bin/bash

message="Enabling GameBoy Color emulation rewind feature which may cause massive slowdown just being on..."
echo "$message"
cowsay -f eyes "$message"

source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
iniConfig " = " "" "/opt/retropie/configs/gbc/retroarch.cfg"
iniSet "rewind_enable" "true"
iniSet "rewind_buffer_size" "20"
iniSet "rewind_granularity" "2"
