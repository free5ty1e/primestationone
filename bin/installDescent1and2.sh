#!/bin/bash

message="Installing, updating, rebuilding Descent Rebirth 1 and 2..."
echo "$message"
cowsay -f flaming-sheep "$message"

echo Installing prerequisites...

sudo apt-get -y install libsdl1.2-dev libsdl-mixer1.2-dev libphysfs-dev

pushd ~

echo Descent 1...
mkdir descent1
cd descent1
wget http://www.dxx-rebirth.com/download/dxx/d1x-rebirth_v0.58.1-src.tar.gz
wget http://www-user.tu-chemnitz.de/~heinm/tmp/d1x-rebirth-rpi.diff.gz
zcat d1x-rebirth-rpi.diff.gz | patch -p1
scons raspberrypi=1
cd ..


echo Descent 2...
mkdir descent2
cd descent2
wget http://www.dxx-rebirth.com/download/dxx/d2x-rebirth_v0.58.1-src.tar.gz
wget http://www-user.tu-chemnitz.de/~heinm/tmp/d2x-rebirth-rpi.diff.gz
zcat d2x-rebirth-rpi.diff.gz | patch -p1
scons raspberrypi=1
cd..


popd