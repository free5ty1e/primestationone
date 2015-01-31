#!/bin/bash

cowsay -f hellokitty Installing binsnroms archive...
echo =====================> Installing binsnroms archive...

pushd ~

megadl 'https://mega.co.nz/#!RAU1iTRQ!MX9VJ5Z3JebWKCU3tatlA4FYBUGn-m_dEM9dCIVwR1Y'
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
