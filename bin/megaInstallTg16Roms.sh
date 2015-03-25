#!/bin/bash

archivename="megaTg16Roms"

message="Installing $archivename mega module..."
echo "$message"
cowsay -f flaming-sheep "$message"

pushd ~

echo Downloading archive from Mega and decompressing it on the fly...
megadl --no-progress --path=- 'https://mega.co.nz/#!M4pDRIxK!P34PCSP9U1ZmPc82W9tQp-jVkAjd7lrr-VizvS_Eogg' | pv -p -s 283569020 | tar xvj

echo Resetting permissions on roms and BIOS folders...
sudo chmod -R 777 ~/RetroPie

popd
echo If you saw any errors, you might consider running a quickUpdatePrimestationOneFiles.sh to ensure you have the latest mega dl link in this script...
