#!/bin/bash

source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

cowsay -f eyes "Ensuring all files here are actually owned by the Pi user!"
echo "Ensuring all files here are actually owned by the Pi user!"
sudo chown -hR pi:pi /home/pi/

installAptRuntimePackages.sh

cowsay -f elephant "Installing first run files..."
echo "Installing first run files..."
installFirstRunFiles.sh

nukeRetroPieSetupRepoAndCheckoutFresh.sh

#Setup all available RetroPie binaries:
sudo ~/RetroPie-Setup/retropie_packages.sh setup binaries

#   PrimestationPrep:
# quickResetPrimestationOne.sh
quickUpdatePrimestationOneFiles.sh

psxAnalogEnable.sh

setDefaultEmulators.sh

setRewinds.sh

ensureRetroarchEmuConfigsIncludesAreLast.sh

installMegaTools.sh

# installMissingPortsFromRetroPieImage.sh
updateRetroPiePackagesAndOtherSetupCommands.sh

fancy_console_message "Now iterating through and installing specified list of RetroPie modules"
updateAndInstallRetroPiePackages.sh 

fancy_console_message "Now ensuring usbromservice will mount with execution enabled"
sudo sed -i -e 's/,noexec//g' /etc/usbmount/usbmount.conf
cat /etc/usbmount/usbmount.conf

# installKodi.sh
# installNodeVirtualGamepads.sh

# installRainbowstream.sh

installPs3RecommendedDriver.sh
installPs4RecommendedDriver.sh

#installMpegRecordingCapability.sh
# sudo RetroPie-Setup/retropie_packages.sh retroarch install_bin
# controllerConfigConstruction.sh

# installDescent1and2.sh

alsamixer

fancy_console_message "About to install LXDE Desktop mode, press CTRL-C to cancel if you already have a desktop installed..."
pause
installWindowedModeLxde.sh

#autoExpandFilesystemNextBoot.sh

