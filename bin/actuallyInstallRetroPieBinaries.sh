#!/bin/bash

cowsay -f mech-and-cow Updating RetroPie binaries...
echo Updating RetroPie binaries...

source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

prepare_to_directly_run_retropie_script_modules

binaries_setup

controllerConfigConstruction.sh
