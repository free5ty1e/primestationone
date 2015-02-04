#!/bin/bash

cowsay -f hellokitty Installing binsnroms_large archive...
echo =====================> Installing binsnroms_large archive...

pushd ~

rm binsnroms_large.7z
megadl 'https://mega.co.nz/#!VAFkwYpa!UVnLPu3Mvr8YRfcwGGywhku7lv0e5SmK4V7m2-wbIdw'
echo Extracting 7z archive.....
7z -d binsnroms_large.7z
cd binsnroms_large
echo Installing....
./installToPrimestationOne.sh
cd ..

echo Cleaning up...
rm binsnroms_large.7z
rm -rf binsnroms_large

popd
echo If you saw any errors, you might consider running a quickUpdatePrimestationOneFiles.sh to ensure you have the latest mega dl link in this script...
