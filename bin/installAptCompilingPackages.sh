#!/bin/bash

echo Obtaining all packages / dependencies in required order to ensure things build correctly, stage 1 of 3...
sudo apt-get install -y libudev-dev libasound2-dev libdbus-1-dev libraspberrypi0 libraspberrypi-bin libraspberrypi-dev

echo Obtaining all packages / dependencies in required order to ensure things build correctly, stage 2 of 3...
sudo apt-get install -y libboost-system-dev libboost-filesystem-dev libboost-date-time-dev libfreeimage-dev libfreetype6-dev libeigen3-dev libcurl4-openssl-dev libasound2-dev cmake g++-4.7 libboost-locale-dev

echo Obtaining all packages / dependencies in required order to ensure things build correctly, stage 3 of 3...
sudo apt-get install -y build-essential automake libtool bison flex xutils-dev libcairo2-dev libffi-dev libmtdev-dev libjpeg-dev libudev-dev libxcb-xfixes0-dev libxcursor-dev libraspberrypi-dev libxkbcommon-dev libxcb-composite0-dev libpam-dev udev python-qt4-dev pyqt4-dev-tools qt4-designer libjack-dev libusb-dev libbluetooth-dev



