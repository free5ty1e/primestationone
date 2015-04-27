#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
fancy_console_message "Installing recommended PS3 controller drivers..." "bud-frogs"

#sudo ~/RetroPie-Setup/retropie_packages.sh ps3controller
installPs3DriverQtSixAdWithGasiaSupportFromSources.sh
