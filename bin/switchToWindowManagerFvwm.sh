#!/bin/bash

echo =====================> Switching to FVWM
sudo apt-get remove -y lxde xorg
sudo apt-get autoremove -y
sudo apt-get install -y fvwm
