#!/bin/bash
echo Creating and copying over some default sixad profiles usable on inexpensive generic bluetooth adapters...
sudo mkdir -p /var/lib/sixad/profiles
sudo cp -v ~/primestationone/reference/var/lib/sixad/profiles/* /var/lib/sixad/profiles/
