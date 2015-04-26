#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
fancy_console_message "Updating RetroPie binaries..." "mech-and-cow"

retroPieNukeAndCheckoutFresh.sh

source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
prepare_to_directly_run_retropie_script_modules

binaries_setup

controllerConfigConstruction.sh
