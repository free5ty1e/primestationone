#!/bin/bash

archivename="megaNesRoms"

message="Installing $archivename mega module..."
echo "$message"
cowsay -f flaming-sheep "$message"

pushd ~

echo Downloading archive from Mega and decompressing it on the fly...
#tar xvz < <(megadl --path - 'https://mega.co.nz/#!00gBgDrZ!c39s9Zaa1RRdDnULIdx3WG0xqwioE6BybnD99KCfmnw')
#7z -d < <(megadl --path - 'https://mega.co.nz/#!YxxQSLoS!sCHIZnsR3ouWfM46Ve30cv3GR6vl7cGz08Zep-e7yvs')
#megadl --path - 'https://mega.co.nz/#!00gBgDrZ!c39s9Zaa1RRdDnULIdx3WG0xqwioE6BybnD99KCfmnw' | tar xz
#megadl --path - 'https://mega.co.nz/#!YxxQSLoS!sCHIZnsR3ouWfM46Ve30cv3GR6vl7cGz08Zep-e7yvs' | 7z -d

megadl --no-progress --path=- 'https://mega.co.nz/#!19IWGZ6K!bccA3KQDURnM3-NB8BnfzDIGo0RdnK9xJ81RH5CAV60' | tar xj

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