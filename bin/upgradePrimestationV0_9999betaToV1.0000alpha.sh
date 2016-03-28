#!/bin/bash
sudo apt-get -y clean
sudo apt-get -y update
sudo apt-get -y upgrade
retroPieNukeAndCheckoutFresh.sh

installMpegRecordingCapability.sh
installPs3RecommendedDriver.sh

quickUpdatePrimestationOneFiles.sh
controllerConfigConstruction.sh

sudo ~/RetroPie-Setup/retropie_packages.sh bashwelcometweak remove
sudo ~/RetroPie-Setup/retropie_packages.sh bashwelcometweak install
