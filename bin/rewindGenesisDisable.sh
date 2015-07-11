#!/bin/bash

message="Disabling Genesis-Megadrive emulation rewind feature which may cause massive slowdown just being on..."
echo "$message"
cowsay -f eyes "$message"

source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
iniConfig " = " "" "/opt/retropie/configs/megadrive/retroarch.cfg"
iniSet "rewind_enable" "false"
iniUnset "rewind_buffer_size" "20"
iniUnset "rewind_granularity" "2"
ensureRetroarchEmuConfigsIncludesAreLast.sh
