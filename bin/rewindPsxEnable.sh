#!/bin/bash

message="Enabling PSX emulation rewind feature which may cause slowdown just being on..."
echo "$message"
cowsay -f eyes "$message"

source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"
iniConfig " = " "" "/opt/retropie/configs/psx/retroarch.cfg"
iniSet "rewind_enable" "true"
iniSet "rewind_buffer_size" "100"
iniSet "rewind_granularity" "240"
ensureRetroarchEmuConfigsIncludesAreLast.sh
