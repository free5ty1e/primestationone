#!/bin/bash
cowsay -f eyes Initiating a REALLY quick-update of the PrimeStation One and theme...
echo Initiating a REALLY quick-update of the PrimeStation One and theme...
pushd ~/primestationone
headsha=$(git rev-parse HEAD)
upstreamsha=$(git rev-parse @{u})
if [ "$headsha" != "$upstreamsha" ]
then
    echo Changes detected upstream!  Updating...
    git pull
    bin/installPrimeStationOneFiles.sh
    updateSplashscreenTextOverlay.sh
else
    echo No changes exist upstream, no need to perform any update operations for this repo!
fi
popd
updateThemePrimestationOne.sh
