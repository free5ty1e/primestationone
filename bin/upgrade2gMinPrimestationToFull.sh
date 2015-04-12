#!/bin/bash
message="Upgrading from minimal 2GB PrimeStation One to Full..."
echo "$message"
cowsay -f skeleton "$message"

sudo bash -c "echo CONF_SWAPSIZE=100 > /etc/dphys-swapfile"
cat /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start

##TODO!  Below unnecessary except need to figure out how to get just the hello_pi source files from the rpi-update without actually doing the update
#Below is now included in 2G image, no need...
#sudo apt-get update
#sudo apt-get -y dist-upgrade
#sudo apt-get -y upgrade
#sudo rm /boot/.firmware_revision
#sudo SKIP_BACKUP=1 rpi-update
#helloPiBuild.sh

installAptRuntimePackages.sh
installFirstRunFiles.sh
quickUpdatePrimestationOneFiles.sh
installMissingPortsFromRetroPieImage.sh
df -h

message="OK... you really should restart now by typing... wait for it... restart"
echo "$message"
cowsay -f skeleton "$message"
