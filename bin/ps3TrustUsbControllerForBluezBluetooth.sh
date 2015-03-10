#!/bin/bash

dialog --title 'PS3 Controller Pairing Step 1 of 2' --msgbox 'Please connect your PS3 controller via USB-CABLE, press PS button and ENTER.' 0 0
#sleep 5
dialog --title 'PS3 Controller Pairing Step 2 of 2' --msgbox 'Please disconnect your PS3 controller from USB-CABLE, press PS button and ENTER.' 0 0
# wait 5 seconds so bluez has enough to create directories
sleep 5
trustAllEncounteredPs3ControllersBluez5.sh
