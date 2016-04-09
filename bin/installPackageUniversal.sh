#!/bin/bash

echo "Installing package on all known package managers because: why not..."

echo "CentOS / RedHat (yum) install, in case this be you..."
sudo yum -y install "$1"

echo "Debian (apt-get) install, in case this be you..."
sudo apt-get install -y "$1"

echo "Cygwin (pacman) install, in case this be you..."
sudo pacman -y install "$1"

echo "Mac OSX (brew) install, in case this be you..."
brew install "$1"
