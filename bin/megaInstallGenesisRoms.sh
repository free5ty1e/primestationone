#!/bin/bash

archivename="megaGenesisRoms"

message="Installing $archivename mega module..."
echo "$message"
cowsay -f flaming-sheep "$message"

pushd ~
rm "$archivename.7z"
rm -rf "$archivename"
megadl 'https://mega.co.nz/#!htBykKoB!4NhSEUflUkkCRsd4_J1l-3Idxdq6zfKeNeYSzscnXE8'
echo Extracting 7z archive.....
7z -d "$archivename.7z"
cd "$archivename"
echo Installing....
./installToPrimestationOne.sh
cd ..

echo Cleaning up...
rm "$archivename.7z"
rm -rf "$archivename"
echo Resetting permissions on roms and BIOS folders...
sudo chmod -R 777 ~/RetroPie

popd
echo If you saw any errors, you might consider running a quickUpdatePrimestationOneFiles.sh to ensure you have the latest mega dl link in this script...
