#!/bin/bash

cowsay -f hellokitty Installing Primestation One theme...
echo Installing Primestation One theme...

pushd ~

echo Removing old theme files...
rm -rf primestationone-estheme

echo Cloning fresh from github repo...
git clone https://github.com/free5ty1e/primestationone-estheme.git
cd primestationone-estheme/

echo Installing primestation one theme...
./installToPrimestationOne.sh
cd ..

popd

echo Setting emulationstation to use the PrimeStation One Theme you just installed...
cp -v ~/primestationone/reference/.emulationstation/es_settings.primestationThemeWithFavs.cfg ~/.emulationstation/es_settings.cfg
