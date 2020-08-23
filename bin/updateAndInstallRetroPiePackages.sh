#!/bin/bash

source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

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
		lr-desmume2015
		lr-prboom
		lr-snes9x
		lr-snes9x-next
		lr-prosystem
		lr-mupen64plus-next
		lr-dosbox
		lr-hatari
		lr-mame2000
		lr-mame2003
		lr-mame2003-plus
		lr-mame2010
		lr-mame2014
		lr-mame2015
		lr-fbalpha2012
		lr-fbalpha
		lr-puae
		lr-vice
		lr-virtualjaguar
		lr-yabause
		lr-atari800
		lr-tyrquake
		lr-tgbdual
		lr-beetle-lynx
		lr-mrboom
		lr-parallel-n64
		lr-ppsspp
		lr-o2em
		lr-beetle-wswan
		lr-gw
		lr-fmsx
		lr-bluemsx
		lr-nxengine
		lr-beetle-pcfx
		lr-dinothawr
		lr-freeintv
		lr-armsnes
		lr-nestopia
		lr-flycast
		lr-genesis-plus-gx
		# lr-mess2016
		
		#Ports (Pi games):
		minecraft
		ags
		dxx-rebirth
		srb2
		darkplaces-quake
		sdlpop
		smw
		eduke32
		sdlpop
		wolf4sdl
		cannonball
		love
		quake3
		solarus
		supertux
		cgenius
		digger
		stratagus


		#Tools:
		kodi
		scraper
		launchingimages
		virtualgamepad
		steamlink
		retronetplay
		# mobilegamepad		
		#retropie-manager


		#Standalone emualators:
		mupen64plus
		drastic
		snes9x
		scummvm
		pisnes
		rpix86
		dosbox-sdl2
		xroar
		redream
		linapple
		basilisk
		# uae4all
		# openmsx
		# sdltrs
		# minivmac
		# advmame
		# advmame-1.4
		# advmame-0.94

		#Obsolete:
		#lr-mupen64plus

		#Experimental:
		# mupen64plus-testing

		# The following take a long time and / or a lot of free space:
		# lr-mame2016
		# lr-mess2016
		# lr-mess
		# lr-mame

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
        fancy_console_message "Installing RetroPie package $CURRENT_PACKAGE_NAME ..."
        sudo ~/RetroPie-Setup/retropie_packages.sh "$CURRENT_PACKAGE_NAME"
		sudo cleanupTempFiles.sh
    done
}

echo "Installing experimental emulators and such that dont require prompting..."
iterateThroughRetroPiePackagesAndInstall
