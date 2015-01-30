#!/bin/bash

cowsay -f hellokitty Installing binsnroms_large archive...
echo =====================> Installing binsnroms_large archive...

pushd ~

megadl 'https://mega.co.nz/#!FZs2gZgA!lWNv4ElD8KakuK2G_FpXcvInx8R-qp3krtlZ7lZilas'
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
