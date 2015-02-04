#!/bin/bash

cowsay -f hellokitty Installing Primestation One theme...
echo =====================> Installing Primestation One theme...

pushd ~

rm themePrimestationOne.7z
megadl 'https://mega.co.nz/#!IY0wwBiR!rIvYSbXdHO5qYiTPdQHBAmFcDeklErj2sNVn2Cd3a78'
echo Extracting 7z archive.....
7z -d themePrimestationOne.7z
cd themePrimestationOne
echo Installing....
./installToPrimestationOne.sh
cd ..

echo Cleaning up...
rm themePrimestationOne.7z
rm -rf themePrimestationOne

popd
echo If you saw any errors, you might consider running a quickUpdatePrimestationOneFiles.sh to ensure you have the latest mega dl link in this script...
