#!/bin/bash
echo Fixing common HDMI audio output issues...
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"

iniConfig "=" "" "/boot/config.txt"

iniUnset "hdmi_drive" 2

echo You really should reboot...
