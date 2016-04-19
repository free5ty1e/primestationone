#!/bin/bash

cowsay -f hellokitty "Installing Rainbowstream..."
echo "Installing Rainbowstream..."

installGoAndAnsize.sh

sudo apt-get -y purge python-pip
sudo apt-get -y install python-pip python-dev libjpeg-dev libfreetype6 libfreetype6-dev zlib1g-dev build-essential links2 lynx

echo "Fixing permissions on your home and local folders just in case!"
sudo chown -R "$USER" ~
sudo chown -R "$USER" /usr/local

easy_install --upgrade pip


virtualenv venv
source venv/bin/activate
pip install rainbowstream



#easy_install --upgrade virtualenv
#easy_install --upgrade twitter
#easy_install --upgrade Pillow
#easy_install --upgrade six
#easy_install --upgrade requests
#easy_install --upgrade python-dateutil
#easy_install --upgrade arrow
#easy_install --upgrade pyfiglet
#easy_install --upgrade PySocks
#easy_install --upgrade rainbowstream
#
#pip install virtualenv twitter rainbowstream
#pip install virtualenv twitter rainbowstream --upgrade

#sudo easy_install Pillow
#sudo easy_install twitter
#sudo easy_install requests
#sudo easy_install six
#sudo easy_install rainbowstream

echo "Now, go to windowed mode and launch rainbowstream from the desktop icon!"
