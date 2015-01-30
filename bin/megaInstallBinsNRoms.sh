#!/bin/bash

cowsay -f hellokitty Installing binsnroms archive...
echo =====================> Installing binsnroms archive...

pushd ~

megadl 'https://mega.co.nz/#!UY8RVYCC!s2RbB1LfpvANCGC2gvhINuVqPDJbgbKtK22ld7PeBC8'
echo Extracting 7z archive.....
7z -d binsnroms.7z
cd binsnroms
echo Installing....
./installToPrimestationOne.sh
cd ..

echo Cleaning up...
rm binsnroms.7z
rm -rf binsnroms

popd
