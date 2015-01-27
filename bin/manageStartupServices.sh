#!/usr/bin/env bash

# Manage startup services menu script for PrimeStationOne
# Because sometimes, you don't need a webmin samba server when you just want to play games in the living room.
# ...but it's neat to have as an option xD

function checkForLogDirectory() {
        # make sure that RetroPie-Setup log directory exists
        if [[ ! -d $scriptdir/logs ]]; then
            mkdir -p "$scriptdir/logs"
            chown $user:$user "$scriptdir/logs"
            if [[ ! -d $scriptdir/logs ]]; then
              echo "Couldn't make directory $scriptdir/logs"
              exit 1
            fi
        fi
}

# =============================================================
#  START OF THE MAIN SCRIPT
# =============================================================

scriptdir=$(dirname $0)
scriptdir=$(cd $scriptdir && pwd)

source "$scriptdir/retropie_packages.sh" init

source "$scriptdir/scriptmodules/retropiesetup.sh"

checkForLogDirectory

# make sure that enough space is available
rps_availFreeDiskSpace 800000

__backtitle="PetRockBlock.com - RetroPie Setup. Installation folder: $rootdir for user $user"

while true; do
    cmd=(dialog --backtitle "$__backtitle" --menu "Choose installation either based on binaries or on sources." 22 76 16)
    options=(1 "Binaries-based INSTALLATION (faster, but possibly not up-to-date)"
             2 "Source-based INSTALLATION (16-20 hours (!), but up-to-date versions)"
             3 "SETUP (only if you already have run one of the installations above)"
             4 "EXPERIMENTAL packages (these are potentially unstable packages)"
             5 "UPDATE RetroPie Setup script"
             6 "UPDATE RetroPie Binaries"
             7 "Perform REBOOT" )
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [ "$choices" != "" ]; then
        case $choices in
            1) rps_main_binaries ;;
            2) rps_main_options ;;
            3) rps_main_setup ;;
            4) rps_main_experimental ;;
            5) rps_main_updatescript ;;
            6) rps_downloadBinaries ;;
            7) rps_main_reboot ;;
        esac
    else
        break
    fi
done
clear
