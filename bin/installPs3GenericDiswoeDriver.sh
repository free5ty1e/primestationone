#!/bin/bash

echo "Adding support for stubborn 3rd party ps3 controllers to pair via bluetooth..."

sudo ~/RetroPie-Setup/retropie_packages.sh "sixaxis"
sudo ~/RetroPie-Setup/retropie_packages.sh "customhidsony"

sudo cleanupTempFiles.sh
