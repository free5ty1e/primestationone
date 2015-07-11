#!/bin/bash

message="Removing the global emulation rewind toggle so that individual emus can once again control their own rewind destinies..."
echo "$message"
cowsay -f eyes "$message"

source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
iniConfig " = " "" "/opt/retropie/configs/all/retroarch.cfg"
iniUnset "rewind_enable" "false"
ensureRetroarchEmuConfigsIncludesAreLast.sh
