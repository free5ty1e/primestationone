#!/bin/bash
sudo apt-get -y clean
sudo apt-get -y update
sudo apt-get -y upgrade
retroPieNukeAndCheckoutFresh.sh
quickUpdatePrimestationOneFiles.sh

installPs3RecommendedDriver.sh
installMpegRecordingCapability.sh
sudo ~/RetroPie-Setup/retropie_packages.sh emulationstation

reinstallBashWelcomeTweak.sh
