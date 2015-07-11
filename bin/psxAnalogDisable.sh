#!/bin/bash
echo Setting psx analog controls disabled...
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
iniConfig " = " "" "/opt/retropie/configs/psx/retroarch.cfg"
iniUnset "input_libretro_device_p1" "5"
iniUnset "input_libretro_device_p2" "5"

iniConfig " = " "" "/opt/retropie/configs/all/retroarch-core-options.cfg"
iniUnset "pcsx_rearmed_pad1type" "analog"
iniUnset "pcsx_rearmed_pad2type" "analog"
ensureRetroarchEmuConfigsIncludesAreLast.sh
