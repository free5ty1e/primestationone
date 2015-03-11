#!/bin/bash

cowsay -f hellokitty Installing Primestation One theme...
echo Installing Primestation One theme...

pushd ~

rm themePrimestationOne.7z
rm -rf themePrimestationOne
megadl 'https://mega.co.nz/#!gMlzVIaD!RaOpNaHwYUbCJZcTD1MNOWHpK5S-wQZHwcraNiwdHKM'
echo Extracting 7z archive.....
7z -d themePrimestationOne.7z
cd themePrimestationOne
echo Installing....
./installToPrimestationOne.sh
cd ..

echo Cleaning up...
rm themePrimestationOne.7z
rm -rf themePrimestationOne

echo Setting emulationstation to use the PrimeStation One Theme you just installed...
cp -v ~/primestationone/reference/.emulationstation/es_settings.primestationtheme.cfg ~/.emulationstation/es_settings.cfg

popd
echo If you saw any errors, you might consider running a quickUpdatePrimestationOneFiles.sh to ensure you have the latest mega dl link in this script...
