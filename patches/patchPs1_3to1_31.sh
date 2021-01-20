#!/bin/bash

echo "This script will attempt to patch your Primestation version indicated first in the script name to the second version indicated in the script name."
read -rsp $'Press any key to continue...\n' -n1 key

quickUpdatePrimestationOneFiles.sh

installAptRuntimePackages.sh 

sudo RetroPie-Setup/retropie_packages.sh openmsx
sudo RetroPie-Setup/retropie_packages.sh lr-beetle-supergrafx
sudo RetroPie-Setup/retropie_packages.sh lr-opera
sudo RetroPie-Setup/retropie_packages.sh usbromservice
