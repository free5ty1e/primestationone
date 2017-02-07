#!/bin/bash

pushd ~

echo "Running a cloud backup before upgrading..."
megaCloudSyncSaveStatesAndSrams.sh

echo "Making some room... you may have to reinstall some mega modules..."
rm -rfv ~/RetroPie/roms/segacd/*
rm -rfv ~/RetroPie/roms/dreamcast/P*
rm -rfv ~/RetroPie/roms/msx/*

echo "Upgrading Wheezy to the latest first if we are still on wheezy..."
sudo apt-get update
sudo apt-get -yf upgrade
sudo apt-get -yf dist-upgrade

echo "Changing apt sources to point to jessie instead of wheezy..."
sudo sed -i 's/wheezy/jessie/g' /etc/apt/sources.list
sudo sed -i 's/deb http:\/\/archive.raspberrypi.org\/debian jessie main/#deb http:\/\/archive.raspberrypi.org\/debian jessie main/g' /etc/apt/sources.list

echo "Upgrading to Raspbian Jessie..."
sudo apt-get update
sudo apt-get -yf upgrade
sudo apt-get -yf dist-upgrade

nukeRetroPieSetupRepoAndCheckoutFresh.sh

sudo RetroPie-Setup/retropie_packages.sh raspbiantools apt_upgrade

#TODO: Need to reboot and have the next steps continue after reboot as a one-shot init?  Maybe, maybe not...

sudo RetroPie-Setup/retropie_packages.sh setup update_packages

installPs3RecommendedDriver.sh

nukePrimestationOneRepoAndCheckoutFresh.sh

quickUpdatePrimestationOneFiles.sh

installKodi.sh

sudo RetroPie-Setup/retropie_packages.sh raspbiantools package_cleanup 

popd

read -p "Press any key to continue rebooting... " -n1 -s
restart
