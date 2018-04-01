#!/bin/bash

function initPackageList {
	RETROPIE_PACKAGE_COMMAND_NAMES=(
		#Upgrade / management commands:
    	setup

		)

	RETROPIE_PACKAGE_COMMANDS=(
		#Upgrade / management commands:
    	update_packages

		)
}

function iterateThroughRetroPiePackageCommandsAndInstall {
    #Iterate through the templates and install them: 
    initPackageList
    for index in ${!RETROPIE_PACKAGE_COMMAND_NAMES[*]}; do
        CURRENT_PACKAGE_NAME="${RETROPIE_PACKAGE_COMMAND_NAMES[$index]}"
        CURRENT_PACKAGE_COMMAND="${RETROPIE_PACKAGE_COMMANDS[$index]}"
        echo "Installing RetroPie package $CURRENT_PACKAGE_NAME with command $CURRENT_PACKAGE_COMMAND..."
        sudo ~/RetroPie-Setup/retropie_packages.sh "$CURRENT_PACKAGE_NAME" "$CURRENT_PACKAGE_COMMAND"
    done
}

echo Installing experimental emulators and such that dont require prompting...
iterateThroughRetroPiePackageCommandsAndInstall
