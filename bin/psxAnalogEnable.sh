#!/bin/bash
echo Setting psx analog controls enabled...
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
iniConfig " = " "" "/opt/retropie/configs/psx/retroarch.cfg"
iniSet "input_libretro_device_p1" "5"
iniSet "input_libretro_device_p2" "5"
