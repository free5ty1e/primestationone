#!/bin/bash

echo Cleaning up temp files...
sudo apt-get -y autoremove
sudo apt-get clean
sudo rm -rf RetroPie-Setup/tmp/*
df -h
