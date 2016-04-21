#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
fancy_console_message "Refreshing IP address -- releasing then restarting networking..." "bud-frogs"
sudo dhclient -r
sudo dhclient -r wlan0
sudo dhclient -r eth0
#sudo dhclient eth0
sudo /etc/init.d/networking restart
ifconfig
