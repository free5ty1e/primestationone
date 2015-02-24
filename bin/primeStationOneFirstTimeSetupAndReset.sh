#!/bin/bash

echo PrimeStationOne First Time and Full Reset Setup script GO!

echo =====================> Making sure things are up to date...
sudo apt-get -f install
sudo apt-get -y update
sudo apt-get -y check
sudo apt-get -y dist-upgrade
sudo apt-get -y upgrade

echo =====================> Updating Pi firmware!  If this happens, you probably have to reboot...
sudo rpi-update

echo =====================> Updating PrimestationOne Specific RetroPie packages
installAllPrimeStationOneEmulatorsFromRetroPie.sh

cowsay -f vader Performing a quick reset of the PrimeStationOne...
cowsay -f vader Installing PrimeStationOne...
echo =====================> Beginning install process of custom stuffs and installation of scripts and executables to their correct locations
~/primestationone/bin/quickResetPrimestationOne.sh

echo =====================> Building hello_pi example and utility projects, because why not...
pushd /opt/vc/src/hello_pi
sudo ./rebuild.sh
popd

installMegaTools.sh
megaInstallBinsNRoms.sh
megaInstallThemePrimeStationOne.sh

read -p "Press any key to restart or CTRL-C to cancel..." -n1 -s
restart

#cowsay Launching retropie setup menu...
#sudo ~/RetroPie-Setup/retropie_setup.sh
