#!/bin/bash
cowsay -f eyes Initiating a REALLY quick-update of the PrimeStation One and theme...
echo Initiating a REALLY quick-update of the PrimeStation One and theme...
pushd ~/primestationone
if ! git diff-index --quiet HEAD --; then
    git pull
    bin/installPrimeStationOneFiles.sh
    popd
    updateSplashscreenTextOverlay.sh
else
    echo No changes exist upstream, no need to perform any update operations for this repo!
fi
popd
updateThemePrimestationOne.sh
