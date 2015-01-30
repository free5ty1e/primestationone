#!/bin/bash

cowsay -f hellokitty Installing Primestation One theme...
echo =====================> Installing Primestation One theme...

pushd ~

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
