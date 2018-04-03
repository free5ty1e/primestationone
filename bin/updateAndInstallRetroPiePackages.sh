#!/bin/bash

function initPackageList {
    RETROPIE_PACKAGE_NAMES=(

    	#LibRetro packages:
		lr-4do
		lr-beetle-vb
		lr-mgba
		lr-vba-next
		lr-virtualjaguar
		lr-pcsx-rearmed
		lr-yabause
		lr-desmume
		lr-prboom
		lr-snes9x-next
		lr-prosystem
		lr-mupen64plus
		lr-dosbox
		lr-hatari
		lr-mame2014
		lr-mame2016
		lr-puae
		lr-vice
		lr-virtualjaguar
		lr-yabause


		#Ports:
		kodi
		minecraft
		ags
		dxx-rebirth
		srb2
		darkplaces-quake
		sdlpop
		smw


		#Tools:
		mobilegamepad
		virtualgamepad
		retropie-manager

		#Standalone emualators:
		mupen64plus
		openmsx
		sdltrs
		minivmac
		drastic
		advmame
		advmame-1.4
		advmame-0.94

		#Experimental:
		mupen64plus-testing

		#Frontends / alternatives to Emulationstation: (Just select one?)
		# emulationstation-dev
		# mehstation
		#pegasus-fe
    )
}

function iterateThroughRetroPiePackagesAndInstall {
    #Iterate through the templates and install them: 
    initPackageList
    for index in ${!RETROPIE_PACKAGE_NAMES[*]}; do
        CURRENT_PACKAGE_NAME="${RETROPIE_PACKAGE_NAMES[$index]}"
        echo "Installing RetroPie package $CURRENT_PACKAGE_NAME ..."
        sudo ~/RetroPie-Setup/retropie_packages.sh "$CURRENT_PACKAGE_NAME"
    done
}

echo "Installing experimental emulators and such that dont require prompting..."
iterateThroughRetroPiePackagesAndInstall
