#!/bin/bash

cowsay -f hellokitty "Installing Rainbowstream..."
echo "Installing Rainbowstream..."

installGoAndAnsize.sh

echo "Fixing permissions on your home and local folders just in case!"
sudo chown -R pi ~
sudo chown -R pi /usr/local

#easy_install --upgrade pip
sudo apt-get -y purge python-pip
sudo apt-get -y install python-pip python-dev build-essential links2 lynx
sudo pip install --upgrade pip
#sudo pip install --upgrade virtualenv
sudo pip uninstall virtualenv twitter rainbowstream -y
sudo pip install virtualenv twitter rainbowstream

echo "Now, go to windowed mode and launch rainbowstream from the desktop icon!"
