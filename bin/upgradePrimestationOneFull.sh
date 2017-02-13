#!/bin/bash

pushd ~

echo "Running a cloud backup before upgrading..."
megaCloudSyncSaveStatesAndSrams.sh

echo "Making some room... you may have to reinstall some mega modules..."
rm -rfv ~/RetroPie/roms/segacd/*
rm -rfv ~/RetroPie/roms/dreamcast/P*
rm -rfv ~/RetroPie/roms/msx/*
rm -rfv ~/RetroPie/roms/3do/*
rm -rfv ~/RetroPie/roms/psx/*
rm -rfv ~/RetroPie/roms/atarijaguar/*
rm -rfv ~/RetroPie/roms/macintosh/*


echo "Upgrading Wheezy to the latest first if we are still on wheezy..."
sudo apt-get -y -f -o Dpkg::Options::="--force-confnew" update
sudo apt-get -y -f -o Dpkg::Options::="--force-confnew" upgrade
sudo apt-get -y -f -o Dpkg::Options::="--force-confnew" dist-upgrade

cleanupTempFiles.sh
sudo apt-get -y -f -o Dpkg::Options::="--force-confnew" install
sudo dpkg --configure -a --force-confnew
sudo apt-get -y -f -o Dpkg::Options::="--force-confnew" install

echo "Changing apt sources to point to jessie instead of wheezy..."
sudo sed -i 's/wheezy/jessie/g' /etc/apt/sources.list
sudo sed -i 's/deb http:\/\/archive.raspberrypi.org\/debian jessie main/#deb http:\/\/archive.raspberrypi.org\/debian jessie main/g' /etc/apt/sources.list

sudo sed -i 's/wheezy/jessie/g' /etc/apt/sources.list.d/raspi.list
sudo sed -i 's/deb http:\/\/archive.raspberrypi.org\/debian jessie main/#deb http:\/\/archive.raspberrypi.org\/debian jessie main/g' /etc/apt/sources.list.d/raspi.list

sudo sed -i 's/wheezy/jessie/g' /etc/apt/sources.list.d/collabora.list 
sudo sed -i 's/deb http:\/\/archive.raspberrypi.org\/debian jessie main/#deb http:\/\/archive.raspberrypi.org\/debian jessie main/g' /etc/apt/sources.list.d/collabora.list 

echo "Upgrading to Raspbian Jessie..."
sudo apt-get -y -f -o Dpkg::Options::="--force-confnew" update
sudo apt-get -y -f -o Dpkg::Options::="--force-confnew" upgrade
sudo apt-get -y -f -o Dpkg::Options::="--force-confnew" dist-upgrade

nukeRetroPieSetupRepoAndCheckoutFresh.sh

cleanupTempFiles.sh
sudo apt-get -y -f -o Dpkg::Options::="--force-confnew" install
sudo dpkg --configure -a --force-confnew
sudo apt-get -y -f -o Dpkg::Options::="--force-confnew" install

sudo RetroPie-Setup/retropie_packages.sh raspbiantools apt_upgrade

cleanupTempFiles.sh
sudo apt-get -y -f -o Dpkg::Options::="--force-confnew" install
sudo dpkg --configure -a --force-confnew
sudo apt-get -y -f -o Dpkg::Options::="--force-confnew" install

echo "Removing limelight package before this happens, it stalls the installation with its geforce pc hunt..."
sudo RetroPie-Setup/retropie_packages.sh limelight remove

sudo RetroPie-Setup/retropie_packages.sh setup update_packages

installWindowedModeLxde.sh

nukePrimestationOneRepoAndCheckoutFresh.sh

installAptRuntimePackages.sh

quickUpdatePrimestationOneFiles.sh

installPs3RecommendedDriver.sh

installKodi.sh

sudo RetroPie-Setup/retropie_packages.sh raspbiantools package_cleanup 
cleanupTempFiles.sh

echo "Reinstalling some of the stuff we removed to make room for the upgrade..."
megaInstallBinsNRoms.sh

popd

read -p "Press any key to continue rebooting... " -n1 -s
restart
