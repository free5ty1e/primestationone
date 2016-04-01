#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
uninstallPs3Driver.sh
fancy_console_message "Installing Genuine Sony-ONLY PS3 controller drivers from RetroPie..." "bud-frogs"
sudo ~/RetroPie-Setup/retropie_packages.sh ps3controller
