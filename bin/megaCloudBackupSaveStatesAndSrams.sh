#!/bin/bash
#source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
CLOUDFOLDER="PrimestationCloud"
FILENAME="PrimeStationSaveArchive"
SAVEFILE="/home/pi/$FILENAME"

pushd ~

echo Clearing out any leftover local save archives...
rm "$SAVEFILE.tar.bz2"
rm "$SAVEFILE.tar.bz2.bak"

echo Retrieving current cloud save archive to backup before we replace it...
megaget "/Root/$CLOUDFOLDER/$SAVEFILE.tar.bz2"
mv "$SAVEFILE.tar.bz2" "$SAVEFILE.tar.bz2.bak"

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

echo Removing existing cloud save archive and archive backup slot...
megarm "/Root/$CLOUDFOLDER/$FILENAME.tar.bz2"
megarm "/Root/$CLOUDFOLDER/$FILENAME.tar.bz2.bak"

echo Uploading your save archive to your cloud storage...
megaput --path "/Root/$CLOUDFOLDER" "$SAVEFILE.tar.bz2"

echo Uploading your save archive backup slot to your cloud storage...
megaput --path "/Root/$CLOUDFOLDER" "$SAVEFILE.tar.bz2.bak"

echo Clearing out any leftover local save archives...
rm "$SAVEFILE.tar.bz2"
rm "$SAVEFILE.tar.bz2.bak"

megals /Root/PrimestationCloud
megadf

popd
