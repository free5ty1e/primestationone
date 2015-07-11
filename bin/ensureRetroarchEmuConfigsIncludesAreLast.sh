#!/bin/bash
echo Ensuring all RetroArch emulator individual cfg files have the master include line as the last line and nowhere else...
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
PATH_TO_INCLUDED_CFG="/opt/retropie/configs/all/retroarch.cfg"

shopt -s globstar
for configfile in /opt/retropie/configs/**/retroarch.cfg; do
    if [ "$configfile" == "$PATH_TO_INCLUDED_CFG" ]; then
        echo "$configfile matches the master config include, not touching this one!"
    else
        echo "$configfile appears to be an individual emu config, processing..."

        echo "Removing any existing include retroarch config line from $configfile..."
        sed -i '/retroarch.cfg/d' "$configfile"

        echo "Stripping any trailing empty lines from the end of $configfile..."
        sed -e :a -e '/^\n*$/{$d;N;};/\n$/ba' "$configfile"

        echo "Readding the master config include at the end of config file $configfile..."
        sudo sh -c "echo '#include \"/opt/retropie/configs/all/retroarch.cfg\"\n' >> $configfile"
    fi
done
