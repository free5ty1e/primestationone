#!/bin/bash

cowsay -f hellokitty Installing binsnroms archive...
echo =====================> Installing binsnroms archive...

pushd ~
rm binsnroms.7z
rm -rf binsnroms
megadl 'https://mega.co.nz/#!0Z8B0YgL!uP_2tHu4cq3nBofI1C9Outbol4Y4zp1w9Dj2wh9LOEE'
echo Extracting 7z archive.....
7z -d binsnroms.7z
cd binsnroms
echo Installing....
./installToPrimestationOne.sh
echo Cleaning up...
rm binsnroms.7z
rm -rf binsnroms

cd ..


popd
echo If you saw any errors, you might consider running a quickUpdatePrimestationOneFiles.sh to ensure you have the latest mega dl link in this script...
