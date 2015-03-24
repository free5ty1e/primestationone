#!/bin/bash

archivename="megaNesRoms"

message="Installing $archivename mega module..."
echo "$message"
cowsay -f flaming-sheep "$message"

pushd ~

echo Downloading archive from Mega and decompressing it on the fly...
megadl --no-progress --path=- 'https://mega.co.nz/#!Q5QE2BQB!Yl_mYx42Ia0cj7mb0FJTvynBa_lz5Qw19TWjLO2c_n0' | pv -p -s 1279761914 | tar xvj

echo Resetting permissions on roms and BIOS folders...
sudo chmod -R 777 ~/RetroPie

popd
echo If you saw any errors, you might consider running a quickUpdatePrimestationOneFiles.sh to ensure you have the latest mega dl link in this script...
