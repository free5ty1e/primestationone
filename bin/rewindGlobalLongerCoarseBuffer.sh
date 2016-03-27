#!/bin/bash

message="Configuring emulation rewind feature to a longer, coarse buffer..."
echo "$message"
cowsay -f eyes "$message"

source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"
iniConfig " = " "" "/opt/retropie/configs/all/retroarch.cfg"
iniSet "rewind_buffer_size" "100"
iniSet "rewind_granularity" "10"
ensureRetroarchEmuConfigsIncludesAreLast.sh
