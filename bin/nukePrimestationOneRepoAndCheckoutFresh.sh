#!/bin/bash

cowsay Nuking and Fresh-Installing and Updating RetroPie-Setup...
echo Now getting the latest RetroPie-Setup script.

message="Nuking and Fresh-Installing Primestation One files..."
echo "$message"
cowsay "$message"

pushd ~
sudo rm -rf primestationone
git clone https://github.com/free5ty1e/primestationone.git
bin/installPrimeStationOneFiles.sh
popd
