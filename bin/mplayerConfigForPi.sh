#!/bin/bash

FILENAME="/etc/mplayer/mplayer.conf"
CONFIG_SETTING="nolirc=yes"
TEMP_CONFIG_FILE="~/mplayer.conf.temp"
cowsay -f calvin Configuring mplayer so we can say things out loud...
if grep -Fxq "$CONFIG_SETTING" "$FILENAME"
then
    # CONFIG_SETTING exists in FILENAME and was found!
    echo "$CONFIG_SETTING is already set in $FILENAME, skipping..."
else
    # CONFIG_SETTING does not exist in FILENAME, was not found!
    sudo bash -c "echo $CONFIG_SETTING >> $FILENAME"
    sudo bash -c "echo   >> $FILENAME"
fi
