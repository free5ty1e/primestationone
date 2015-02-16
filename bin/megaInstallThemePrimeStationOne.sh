#!/bin/bash

cowsay -f hellokitty Installing Primestation One theme...
echo =====================> Installing Primestation One theme...

pushd ~

rm themePrimestationOne.7z
rm -rf themePrimestationOne
megadl 'https://mega.co.nz/#!FNNmnSJJ!asFrt-W9OrH18vBzG8boUk-ae3yVhYIKYlo8Tz7zmvE'
echo Extracting 7z archive.....
7z -d themePrimestationOne.7z
cd themePrimestationOne
echo Installing....
./installToPrimestationOne.sh
echo Cleaning up...
rm themePrimestationOne.7z
rm -rf themePrimestationOne

cd ..


popd
echo If you saw any errors, you might consider running a quickUpdatePrimestationOneFiles.sh to ensure you have the latest mega dl link in this script...
