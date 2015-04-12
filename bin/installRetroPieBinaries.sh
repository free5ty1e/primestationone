#!/bin/bash

cowsay -f mech-and-cow Updating RetroPie binaries...
echo Updating RetroPie binaries...
scriptdir="/home/pi/RetroPie-Setup"
source "$scriptdir/scriptmodules/system.sh"
source "$scriptdir/scriptmodules/helpers.sh"
source "$scriptdir/scriptmodules/packages.sh"
source "$scriptdir/scriptmodules/admin/setup.sh"
binaries_setup
