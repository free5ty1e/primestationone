#!/bin/bash

message="Installing, updating, rebuilding FoFiX (Frets On Fire X) for Python 2.6..."
echo "$message"
cowsay -f flaming-sheep "$message"

echo Installing prerequisites...
sudo apt-get -y install python2.6 python-pygame python-opengl python-numpy python-imaging python-dev build-essential cython pkg-config libgl1-mesa-dev libglu1-mesa-dev libglib2.0-dev libsdl1.2-dev libsdl-mixer1.2-dev libogg-dev libtheora-dev libswscale-dev libsoundtouch-dev gettext libvorbis-dev




pushd ~

echo Cloning and checking out FoFiX if not already exists...
git clone https://github.com/fofix/fofix.git

cd fofix

echo Updating existing FoFiX...
git pull

echo Rebuilding all Cython modules...
sudo python setup.py build_ext --inplace --force

popd
