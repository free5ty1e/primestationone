#!/bin/bash

cowsay -f mech-and-cow Updating RetroPie binaries...
echo Updating RetroPie binaries...

# global variables ==========================================================

# main retropie install location
rootdir="/opt/retropie"

user="$SUDO_USER"
[[ -z "$user" ]] && user=$(id -un)

home="$(eval echo ~$user)"
datadir="$home/RetroPie"
biosdir="$datadir/BIOS"
romdir="$datadir/roms"
emudir="$rootdir/emulators"
configdir="$rootdir/configs"

scriptdir="/home/pi/RetroPie-Setup"
__logdir="$scriptdir/logs"
__tmpdir="$scriptdir/tmp"
__builddir="$__tmpdir/build"
__swapdir="$__tmpdir"

# check, if sudo is used
if [[ $(id -u) -ne 0 ]]; then
echo "Script must be run as root. Try 'sudo $0'"
exit 1
fi

__backtitle="PetRockBlock.com - RetroPie Setup. Installation folder: $rootdir for user $user"

source "$scriptdir/scriptmodules/system.sh"
source "$scriptdir/scriptmodules/helpers.sh"
source "$scriptdir/scriptmodules/packages.sh"
source "$scriptdir/scriptmodules/admin/setup.sh"

setup_env

# set default gcc version
gcc_version "$__default_gcc_version"

mkUserDir "$romdir"
mkUserDir "$biosdir"

rp_registerAllModules

ensureFBMode 320 240

binaries_setup

controllerConfigConstruction.sh
