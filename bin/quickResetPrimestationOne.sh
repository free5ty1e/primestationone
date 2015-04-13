#!/bin/bash

function pause()
{
    read -p "$*"
}

cowsay -f eyes Shrinking swap to 10MB to make room for a reset on a 2.1GB filesystem...
sudo bash -c "echo CONF_SWAPSIZE=1 > /etc/dphys-swapfile"
cat /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile stop
sudo /etc/init.d/dphys-swapfile start

echo Applying various APT fixes just in case there is a problem in the package manager...
sudo apt-get -fy install
sudo dpkg --configure -a

echo Ensuring all required apt packages are installed...
installAptRuntimePackages.sh

cowsay -f eyes Ensuring all files here are actually owned by the Pi user!
sudo chown -hR pi:pi /home/pi/

#removeUnneededAndOutdatedAptPackages.sh

cowsay -f elephant Installing first run files...
echo Installing first run files...
installFirstRunFiles.sh

#echo Installing corrected blank gamelist.xml files...
#installBlankGamelists.sh

autoStartEmulationstationEnforce.sh

retroPieNukeAndCheckoutFresh.sh

quickUpdatePrimestationOneFiles.sh

cowsay Enabling rewind functionality on basic emulators...
rewindAtari2600Enable.sh
rewindGenesisEnable.sh
rewindNesEnable.sh
rewindSnesEnable.sh
rewindTg16Enable.sh
rewindGamegearEnable.sh
rewindGameboyEnable.sh
rewindGameboyColorEnable.sh
rewindMastersystemEnable.sh
