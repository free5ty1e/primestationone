#!/bin/bash

#Link linkedroms to actual location of roms (USB? SD?)
MAIN_ROMS_USB_LOCATION="/media/usb/RetroPie/roms"
MAIN_ROMS_SD_LOCATION="/home/pi/RetroPie/roms"
if [ -d "$MAIN_ROMS_USB_LOCATION" ]; then
    MAIN_ROMS_LINKED_LOCATION="$MAIN_ROMS_USB_LOCATION"
else
    MAIN_ROMS_LINKED_LOCATION="$MAIN_ROMS_SD_LOCATION"
fi
ROMS_SYMLINK_LOCATION="/home/pi/linkedroms"
if [ ! -e "$ROMS_SYMLINK_LOCATION" ] || [ -d "$ROMS_SYMLINK_LOCATION" ] ; then
#if the symlink is broken or if it does not exist, then remove and recreate it with the current roms location
    echo "$ROMS_SYMLINK_LOCATION is a broken symlink!  Recreating with $MAIN_ROMS_LINKED_LOCATION"
    rm -f "$ROMS_SYMLINK_LOCATION"
    ln -s "$MAIN_ROMS_LINKED_LOCATION" "$ROMS_SYMLINK_LOCATION"
fi
