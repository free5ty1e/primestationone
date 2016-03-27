#!/bin/bash
echo Fixing common HDMI audio output issues...
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"

iniConfig "=" "" "/boot/config.txt"

iniUnset "hdmi_drive" 2
iniUnset "hdmi_force_hotplug" 1

echo You really should reboot...
