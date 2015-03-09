#!/bin/bash
cowsay -f stimpy Quick-updating the PrimeStation One!
cd ~/primestationone
echo Installing PrimeStationOne files to their proper locations....
bin/installPrimeStationOneFiles.sh
echo Ensuring all required apt packages are installed...

echo Applying various APT fixes just in case there is a problem in the package manager...
sudo apt-get -fy install
sudo dpkg --configure -a

installAptRuntimePackages.sh
updateSplashscreenVersion.sh

echo To update RetroPie-Setup stuffs, do it from the retropie_setup.sh menu as it is not just a simple git pull...

cleanupTempFiles.sh

#echo Updating latest RetroPie-Setup files from git repo...
#cd ~/RetroPie-Setup
#sudo git pull
#cd ~

#echo =====================> Launching mplayer config 4 pi script...
#mplayerConfigForPi.sh

#echo =====================> Installing system status page auto updater cronjob...
#installCronUpdateForSysStatusHomepage.sh

#echo =====================> Installing PrimeStation One onReboot autoupdater cronjob...
#installCronRebootAutoQuickUpdatePrimeStationOne.sh
