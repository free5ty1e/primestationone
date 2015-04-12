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

__logdir="$scriptdir/logs"
__tmpdir="$scriptdir/tmp"
__builddir="$__tmpdir/build"
__swapdir="$__tmpdir"

scriptdir="/home/pi/RetroPie-Setup"
source "$scriptdir/scriptmodules/system.sh"
source "$scriptdir/scriptmodules/helpers.sh"
source "$scriptdir/scriptmodules/packages.sh"
source "$scriptdir/scriptmodules/admin/setup.sh"

setup_env

binaries_setup
