#!/bin/bash

echo "Following https://pimylifeup.com/raspberry-pi-plex-server/"

echo "Installing apt-transport-https"
sudo apt-get install -y apt-transport-https

echo "Downloading plexsign.key to apt-key"
curl https://downloads.plex.tv/plex-keys/PlexSign.key | sudo apt-key add -

echo "Adding Plex repo to apt-get sources.list"
echo deb https://downloads.plex.tv/repo/deb public main | sudo tee /etc/apt/sources.list.d/plexmediaserver.list

echo "Updating apt cache"
sudo apt-get update

echo "Installing Plex Media Server via apt-get"
sudo apt install -y plexmediaserver

