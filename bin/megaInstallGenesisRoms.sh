#!/bin/bash

archivename="megaGenesisRoms"

message="Installing $archivename mega module..."
echo "$message"
cowsay -f flaming-sheep "$message"

pushd ~
rm "$archivename.7z"
megadl 'https://mega.co.nz/#!8toBUZpQ!GIv29CHAo87S0mQHT-gL3CstF3aYdw1gjj1AiJU0UWY'
echo Extracting 7z archive.....
7z -d "$archivename.7z"

echo Cleaning up...
rm "$archivename.7z"
echo Resetting permissions on roms and BIOS folders...
sudo chmod -R 777 ~/RetroPie

popd
echo If you saw any errors, you might consider running a quickUpdatePrimestationOneFiles.sh to ensure you have the latest mega dl link in this script...
