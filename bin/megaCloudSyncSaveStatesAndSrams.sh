#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

#CLOUDFOLDER="PrimestationCloud"
TEMPFILENAME="PrimeStationSaveArchive"
TEMPSAVEFILE="/home/pi/$TEMPFILENAME"


echo Clearing out any leftover local temp save archives...
pushd ~
rm "$TEMPSAVEFILE.tar.bz2"

echo "To achieve a tar-based sync without wasting storage space:"
echo " 1) Archive current local snapshot of save states and SRAMs to temp file...."
cloud_create_backup_archive "$TEMPSAVEFILE"
popd

echo " 2) Execute a full in-place cloud restore, temporarily overwriting some of the latest saves...."
megaCloudRestoreSaveStatesAndSrams.sh

echo " 3) Restore the temp file local snapshot of latest save states and SRAMs, overwriting the older saves with the latest saves in place...."
pushd ~
tar xvjf "$TEMPFILENAME.tar.bz2" --strip-components=2
#rm "$TEMPSAVEFILE.tar.bz2"
popd

echo " 4) Execute a full in-place cloud backup, which will now be a freshly-created and synchronized save archive for this Primestation One account...."
megaCloudBackupSaveStatesAndSrams.sh
