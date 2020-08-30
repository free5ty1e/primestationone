#!/bin/bash

source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

function initPackageList {
    RETROPIE_PACKAGE_NAMES=(

		# The following take a long time and / or a lot of free space:
		lr-mame2016
		lr-mess2016
		lr-mess
		lr-mame

    )
}

function iterateThroughRetroPiePackagesAndInstall {
    #Iterate through the templates and install them: 
    initPackageList
    for index in ${!RETROPIE_PACKAGE_NAMES[*]}; do
        CURRENT_PACKAGE_NAME="${RETROPIE_PACKAGE_NAMES[$index]}"
        fancy_console_message "Installing RetroPie package $CURRENT_PACKAGE_NAME ..."
        sudo ~/RetroPie-Setup/retropie_packages.sh "$CURRENT_PACKAGE_NAME"
		sudo cleanupTempFiles.sh
    done
}

echo "Installing demanding and large emulators and such that dont require prompting..."
iterateThroughRetroPiePackagesAndInstall
