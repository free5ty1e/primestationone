#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
CLOUDFOLDER="PrimestationCloud"
FILENAME="PrimeStationSaveArchive"
SAVEFILE="/home/pi/$FILENAME"

pushd ~

echo Clearing out any leftover local save archives...
rm "$SAVEFILE.tar.bz2"
rm "$SAVEFILE.tar.bz2.bak"

echo Retrieving current cloud save archive to backup before we replace it...
megaget "/Root/$CLOUDFOLDER/$FILENAME.tar.bz2"
mv "$SAVEFILE.tar.bz2" "$SAVEFILE.tar.bz2.bak"

cloud_create_backup_archive "$SAVEFILE"

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
