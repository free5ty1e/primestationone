#!/bin/bash

echo Switching to LXDE
sudo apt-get remove -y fvwm fvwm-icons
sudo apt-get autoremove -y
sudo apt-get install -y lxde xorg
