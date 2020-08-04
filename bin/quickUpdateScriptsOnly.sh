#!/bin/bash
cowsay -f eyes Initiating a quick-update of the PrimeStation One...
pushd ~/primestationone
echo Updating latest PrimeStationOne files from git repo...
git pull
echo "Installing PrimeStationOne files to their proper locations...."
bin/installPrimeStationOneFiles.sh
popd
