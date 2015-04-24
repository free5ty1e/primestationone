#!/bin/bash
#source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
CLOUDFOLDER="PrimestationCloud"
SAVEFILE="/home/pi/PrimeStationSaveArchive"

echo Finding and updating your archove of save states and SRAM files...
for saveStateFile in /home/pi/RetroPie/roms/*/*.state*; do
    echo "Archiving saveStateFile $saveState..."
    tar --append --file="$SAVEFILE.tar" "$saveStateFile"
done

echo "Compressing your saveStateFile $saveStateFile.tar..."
compressBz2.sh "$SAVEFILE.tar"

echo "Creating cloud folder $CLOUDFOLDER..."
megamkdir "/Root/$CLOUDFOLDER"

echo Uploading your save archive to your cloud storage...
megaput --path "/Root/$CLOUDFOLDER/" "$SAVEFILE.tar.bz2"

#megals
megadf
