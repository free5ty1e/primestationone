#!/bin/bash
echo Fixing common HDMI audio output issues...
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"

iniConfig "=" "" "/boot/config.txt"

iniSet "hdmi_drive" 2
iniSet "hdmi_force_hotplug" 1

echo You really should reboot...
