#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

echo Clearing out all bluetooth pairings...
sudo rm -rf /var/lib/bluetooth/*
