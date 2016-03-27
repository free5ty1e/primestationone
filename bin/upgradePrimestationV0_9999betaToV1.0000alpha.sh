#!/bin/bash
sudo apt-get -y clean
sudo apt-get -y update
sudo apt-get -y upgrade

installMpegRecordingCapability.sh
installPs3RecommendedDriver.sh
retroPieNukeAndCheckoutFresh.sh
quickUpdatePrimestationOneFiles.sh
controllerConfigConstruction.sh
