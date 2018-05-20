#!/bin/bash

echo Cleaning up temp files...
rm -rf /home/pi/RetroPie-Setup/tmp
sudo apt-get -y autoremove
sudo apt-get clean

df -h
