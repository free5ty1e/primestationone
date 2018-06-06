#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
CLOUDFOLDER="PrimestationCloud"
FILENAME="PrimeStationSaveArchive"
SAVEFILE="/home/pi/$FILENAME"

echo Connecting to linked Mega PrimestationCloud backup archive...
megals /Root/PrimestationCloud
megadf

download_install_mega_archive_from_cloud_storage_on_the_fly "$FILENAME" / 23172791 "/Root/$CLOUDFOLDER/$FILENAME.tar.bz2"
