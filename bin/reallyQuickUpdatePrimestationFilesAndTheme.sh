#!/bin/bash
cowsay -f eyes Initiating a REALLY quick-update of the PrimeStation One and theme...
echo Initiating a REALLY quick-update of the PrimeStation One and theme...
pushd ~/primestationone
git pull
bin/installPrimeStationOneFiles.sh
popd
updateThemePrimestationOne.sh
updateSplashscreenTextOverlay.sh
