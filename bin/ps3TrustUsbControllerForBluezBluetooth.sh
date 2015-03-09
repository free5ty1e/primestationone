#!/bin/bash

dialog --title 'PS3 Controller Pairing' --msgbox 'Please connect your PS3 controller via USB-CABLE, press PS button and ENTER.' 0 0
# wait 5 seconds so bluez has enough to create directories
sleep 5
for file in $(grep -l "Name=PLAYSTATION(R)3 Controller" /var/lib/bluetooth/*/*/info); do
    sudo sed -i "s/Trusted=false/Trusted=true/g" $file
done
/etc/init.d/bluetooth restart
