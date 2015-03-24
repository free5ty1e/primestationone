#!/bin/bash

archivename="megaAtari2600Roms"

message="Installing $archivename mega module..."
echo "$message"
cowsay -f flaming-sheep "$message"

pushd ~

echo Downloading archive from Mega and decompressing it on the fly...
#megadl --no-progress --path=- 'https://mega.co.nz/#!0khDHJBT!q1GDo3pwHNp1_APQk205GWw32mzFsjpTTcs3g22NOL0' | tar xj
megadl --no-progress --path=- 'https://mega.co.nz/#!Zg4CwbyT!4F5mYhMkHwqATZD7lXX3ldm8WWC--qTsoaPXflWG7jM' | pv -p -s 5397363 | tar xvj

echo Resetting permissions on roms and BIOS folders...
sudo chmod -R 777 ~/RetroPie

popd
echo If you saw any errors, you might consider running a quickUpdatePrimestationOneFiles.sh to ensure you have the latest mega dl link in this script...
