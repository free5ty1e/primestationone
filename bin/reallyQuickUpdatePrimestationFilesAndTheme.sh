#!/bin/bash

message="Initiating a REALLY quick-update of the PrimeStation One and theme..."
echo "$message"
cowsay -f eyes "$message"

pushd ~/primestationone
git fetch
headsha=$(git rev-parse HEAD)
upstreamsha=$(git rev-parse @{u})
if [ "$headsha" != "$upstreamsha" ]
then
    echo Changes detected upstream!  Updating...
    git pull
    bin/installPrimeStationOneFiles.sh
    quickCreateFoldersAndLinksAndRemoveOldFiles.sh
    updateSplashscreenTextOverlay.sh
else
    echo No changes exist upstream, no need to perform any update operations for this repo!
fi
popd
updateThemePrimestationOne.sh
