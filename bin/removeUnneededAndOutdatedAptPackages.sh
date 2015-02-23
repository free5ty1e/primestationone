#!/bin/bash

function pause()
{
    read -p "$*"
}

cowsay -f eyes Removing unneeded and outdated packages...
echo Removing unneeded and outdated packages...
sudo apt-get -y purge pulseaudio mplayer
sudo apt-get -y autoremove
sudo apt-get -y clean
