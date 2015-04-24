#!/bin/bash
#source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
CLOUDFOLDER="PrimestationCloud"
FILENAME="PrimeStationSaveArchive"
SAVEFILE="/home/pi/$FILENAME"

echo Finding and updating your archove of save states and SRAM files...
for saveStateFile in /home/pi/RetroPie/roms/*/*.state*; do
    echo "Archiving saveStateFile $saveStateFile..."
    tar --append --file="$SAVEFILE.tar" "$saveStateFile"
done

for SRAMFile in /home/pi/RetroPie/roms/*/*.srm; do
    echo "Archiving SRAMFile $SRAMFile..."
    tar --append --file="$SAVEFILE.tar" "$SRAMFile"
done

echo "Compressing your save file $SAVEFILE.tar..."
compressBz2.sh "$SAVEFILE.tar"

echo "Creating cloud folder $CLOUDFOLDER..."
megamkdir "/Root/$CLOUDFOLDER"

echo Removing existing cloud save archive backup slot...
megarm "/Root/$CLOUDFOLDER/$FILENAME.tar.bz2.bak"

echo Moving existing cloud save archive to backup slot...
megamv "/Root/$CLOUDFOLDER/$FILENAME.tar.bz2" "/Root/$CLOUDFOLDER/$FILENAME.bak"

echo Uploading your save archive to your cloud storage...
megaput --path "/Root/$CLOUDFOLDER/" "$SAVEFILE.tar.bz2"

megals /Root/PrimestationCloud
megadf
