#!/bin/bash

archivename="megaAtari2600Roms"

message="Installing $archivename mega module..."
echo "$message"
cowsay -f flaming-sheep "$message"

pushd ~

echo Downloading archive from Mega and decompressing it on the fly...
#tar xvz < <(megadl --path - 'https://mega.co.nz/#!00gBgDrZ!c39s9Zaa1RRdDnULIdx3WG0xqwioE6BybnD99KCfmnw')
#7z -d < <(megadl --path - 'https://mega.co.nz/#!YxxQSLoS!sCHIZnsR3ouWfM46Ve30cv3GR6vl7cGz08Zep-e7yvs')
#megadl --path - 'https://mega.co.nz/#!00gBgDrZ!c39s9Zaa1RRdDnULIdx3WG0xqwioE6BybnD99KCfmnw' | tar xz
#megadl --path - 'https://mega.co.nz/#!YxxQSLoS!sCHIZnsR3ouWfM46Ve30cv3GR6vl7cGz08Zep-e7yvs' | 7z -d

megadl --no-progress --path=- 'https://mega.co.nz/#!ZwAjSTzY!VI7ePrA6orZrBm2dEtVvIH0o0H7qnzWiMd0Aa2V5dug' | tar xj

#rm "$archivename.7z"
#megadl --path - 'https://mega.co.nz/#!YxxQSLoS!sCHIZnsR3ouWfM46Ve30cv3GR6vl7cGz08Zep-e7yvs'
#echo Extracting 7z archive.....
#7z -d "$archivename.7z"
#
#echo Cleaning up...
#rm "$archivename.7z"

echo Resetting permissions on roms and BIOS folders...
sudo chmod -R 777 ~/RetroPie

popd
echo If you saw any errors, you might consider running a quickUpdatePrimestationOneFiles.sh to ensure you have the latest mega dl link in this script...
