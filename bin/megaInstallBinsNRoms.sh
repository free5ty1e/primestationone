#!/bin/bash

cowsay -f hellokitty Installing binsnroms archive...
echo Installing binsnroms archive...

pushd ~
rm binsnroms.7z
rm -rf binsnroms
megadl 'https://mega.co.nz/#!ddVVXLQB!CJiHoJDlVIPdyFEuyhs8lmeTmXuCzbzNRMI4zFp6ODw'
echo Extracting 7z archive.....
7z -d binsnroms.7z
cd binsnroms
echo Installing....
./installToPrimestationOne.sh
cd ..

echo Cleaning up...
rm binsnroms.7z
rm -rf binsnroms
echo Resetting permissions on roms and BIOS folders...
sudo chmod -R 777 ~/RetroPie

popd
echo If you saw any errors, you might consider running a quickUpdatePrimestationOneFiles.sh to ensure you have the latest mega dl link in this script...
