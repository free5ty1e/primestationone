#!/bin/bash

archivename="megaGenesisRoms"

message="Installing $archivename mega module..."
echo "$message"
cowsay -f flaming-sheep "$message"

pushd ~

echo Downloading archive from Mega and decompressing it on the fly...
megadl --no-progress --path=- 'https://mega.co.nz/#!dhwUVSyT!zoSCiKF_sgHP6C0nVoRvlue47xfItFASsiZHpt81bAQ' | pv -p -s 4188107529 | tar xvj

echo Resetting permissions on roms and BIOS folders...
sudo chmod -R 777 ~/RetroPie

popd
echo If you saw any errors, you might consider running a quickUpdatePrimestationOneFiles.sh to ensure you have the latest mega dl link in this script...
