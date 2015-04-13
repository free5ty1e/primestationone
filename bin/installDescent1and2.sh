#!/bin/bash

message="Installing, updating, rebuilding Descent Rebirth 1 and 2..."
echo "$message"
cowsay -f flaming-sheep "$message"

echo Installing prerequisites...

sudo apt-get -y install libsdl1.2-dev libsdl-mixer1.2-dev libphysfs-dev scons
cleanupTempFiles.sh

pushd ~

echo Descent 1...
mkdir descent1
cd descent1
rm d1x-rebirth_v0.58.1-src.tar.gz
wget http://www.dxx-rebirth.com/download/dxx/d1x-rebirth_v0.58.1-src.tar.gz
tar xvzf d1x-rebirth_v0.58.1-src.tar.gz
cd d1x-rebirth_v0.58.1-src
#wget http://www-user.tu-chemnitz.de/~heinm/tmp/d1x-rebirth-rpi.diff.gz
#zcat d1x-rebirth-rpi.diff.gz | patch -p1
scons -c
scons raspberrypi=1 debug=1

cd ~

echo Retrieving Descent 1 shareware content...
mkdir .d1x-rebirth
cd .d1x-rebirth
wget http://www.dxx-rebirth.com/download/dxx/content/descent-pc-shareware.zip
unzip descent-pc-shareware.zip
rm descent-pc-shareware.zip

cd ~

echo Descent 2...
mkdir descent2
cd descent2
rm d2x-rebirth_v0.58.1-src.tar.gz
wget http://www.dxx-rebirth.com/download/dxx/d2x-rebirth_v0.58.1-src.tar.gz
tar xvzf d2x-rebirth_v0.58.1-src.tar.gz
cd d2x-rebirth_v0.58.1-src
#wget http://www-user.tu-chemnitz.de/~heinm/tmp/d2x-rebirth-rpi.diff.gz
#zcat d2x-rebirth-rpi.diff.gz | patch -p1
scons -c
scons raspberrypi=1

cd ~

echo Retrieving Descent 2 shareware content...
mkdir .d2x-rebirth
cd .d2x-rebirth
wget http://www.dxx-rebirth.com/download/dxx/content/descent2-pc-demo.zip
unzip descent2-pc-demo.zip
rm descent2-pc-demo.zip

popd