#!/bin/bash

function pause()
{
    read -p "$*"
}

echo PrimeStationOne Setup script - to be run on the PI after copying the PrimeStationOne files on top of a functional RetroPie image.
echo Run the primeStationOneCopyFilesToPi script first from the installing computer after setting up an SSH key for passwordless SCP transfers... or just clone the github repo directly onto the Pi, easier...

echo =====================> Making sure things are up to date...
sudo apt-get -f install
sudo apt-get -y update
sudo apt-get -y check
sudo apt-get -y dist-upgrade
sudo apt-get -y upgrade

echo =====================> Updating Pi firmware!  If this happens, you probably have to reboot...
sudo rpi-update

cowsay -f vader Installing PrimeStationOne...
echo =====================> Beginning install process of custom stuffs and installation of scripts and executables to their correct locations
~/primestationone/bin/quickUpdatePrimestationOneFiles.sh

cowsay -f elephant Installing first run files...
echo Installing first run files...
installFirstRunFiles.sh

echo =====================> Installing corrected blank gamelist.xml files...
installBlankGamelists.sh

echo =====================> Building hello_pi example and utility projects, because why not...
pushd /opt/vc/src/hello_pi
sudo ./rebuild.sh
popd

cowsay Nuking and Fresh-Installing and Updating RetroPie-Setup...
echo =====================> Now getting the latest RetroPie-Setup script.
pushd ~
sudo rm -rf RetroPie-Setup
git clone --depth=0 git://github.com/petrockblog/RetroPie-Setup.git
cd ~/RetroPie-Setup
git pull
chmod +x retropie_packages.sh
chmod +x retropie_setup.sh
popd

echo =====================> Updating PrimestationOne Specific RetroPie packages
installAllPrimeStationOneEmulatorsFromRetroPie.sh

#cowsay Launching retropie setup menu...
#sudo ~/RetroPie-Setup/retropie_setup.sh
