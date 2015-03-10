#!/bin/bash

echo Now mass-trusting all PS3 controllers encountered and saved in this Primestations bluetooth library...
#TODO: Iterate automatically through list of PS3 headers in primestationone/reference used to construct controller configs so all possible matching named controllers will be auto trusted....
sudo bash -c 'for file in $(grep -l "Name=PLAYSTATION(R)3 Controller" /var/lib/bluetooth/*/*/info); do
    sed -i "s/Trusted=false/Trusted=true/g" $file
done
/etc/init.d/bluetooth restart'
