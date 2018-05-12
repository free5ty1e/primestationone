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
		lr-desmume2015
		lr-prboom
		lr-snes9x
		lr-snes9x-next
		lr-prosystem
		lr-mupen64plus
		lr-dosbox
		lr-hatari
		lr-mame2003
		lr-mame2003-plus
		lr-mame2010
		lr-mame2014
		lr-mame2016
		lr-fbalpha2012
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
		# lr-mess2016
		
		#The following require gcc 5.0 or later to compile:
		lr-mess
		lr-mame


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
		

		#Tools:
		kodi
		mobilegamepad
		virtualgamepad
		retropie-manager
		scraper

		#Standalone emualators:
		mupen64plus
		openmsx
		sdltrs
		minivmac
		drastic
		advmame
		advmame-1.4
		advmame-0.94
		snes9x
		uae4all
		scummvm
		pisnes
		rpix86
		dosbox-sdl2



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
