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
		emulationstation-dev
		# mehstation
		#pegasus-fe
    )
}

function iterateThroughRetroPiePackagesAndInstall {
    #Iterate through the templates and install them: 
    TEMPLATE_REPORT=""
    TEMPLATE_VERBOSE_REPORT=""
    initPackageList
    for index in ${!RETROPIE_PACKAGE_NAMES[*]}; do
        CURRENT_PACKAGE_NAME="${RETROPIE_PACKAGE_NAMES[$index]}"
        echo "Installing RetroPie package $CURRENT_PACKAGE_NAME ..."
        sudo ~/RetroPie-Setup/retropie_packages.sh "$CURRENT_PACKAGE_NAME"
    done
}

retroPieNukeAndCheckoutFresh.sh

cowsay -f stegosaurus Now installing one thing that will require your attention with prompting at the end...

cowsay Installing RetroPie binaries...
installRetroPieBinaries.sh

echo Installing experimental emulators and such that dont require prompting...
iterateThroughRetroPiePackagesAndInstall

#sudo ~/RetroPie-Setup/retropie_packages.sh reicast
installReicastPrimestationEdition.sh



#sudo ~/RetroPie-Setup/retropie_packages.sh inputstation


#cowsay -f mech-and-cow Updating RetroPie packages specific to the PrimeStation One...
#sudo ~/RetroPie-Setup/retropie_packages.sh aptpackages
#cowsay -f elephant Installing required module packagerepository
#sudo ~/RetroPie-Setup/retropie_packages.sh packagerepository
#cowsay -f elephant Installing required modules UInput, JoyDev, ALSA
#sudo ~/RetroPie-Setup/retropie_packages.sh modules
#cowsay -f elephant Installing required module runcommand
#sudo ~/RetroPie-Setup/retropie_packages.sh runcommand
#
#cowsay -f elephant Installing roms folder sharing module sambashares
#sudo ~/RetroPie-Setup/retropie_packages.sh sambashares
#
#cowsay -f stegosaurus Updating retroarch joypad autoconfigs...
#sudo ~/RetroPie-Setup/retropie_packages.sh retroarchautoconf
#sudo ~/RetroPie-Setup/retropie_packages.sh esconfig
#sudo ~/RetroPie-Setup/retropie_packages.sh retropiemenu
#
#cowsay -f stegosaurus Installing missing ports and emulators...
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-4do
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-o2em
#sudo ~/RetroPie-Setup/retropie_packages.sh libretro-vecx
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-tyrquake
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-nestopia
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-yabause
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-virtualjaguar
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-snes9x-next
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-prosystem
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-mupen64plus
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-mgba
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-beetle-vb
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-gpsp
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-prboom
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-stella
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-pcsx-rearmed
#
#echo Installing CaveStory NXEngine...
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-nxengine
#
##sudo ~/RetroPie-Setup/retropie_packages.sh fbalibretro
##sudo ~/RetroPie-Setup/retropie_packages.sh fmsx-libretro
##sudo ~/RetroPie-Setup/retropie_packages.sh gbclibretro
##sudo ~/RetroPie-Setup/retropie_packages.sh genesislibretro
##sudo ~/RetroPie-Setup/retropie_packages.sh libretro-handy
##sudo ~/RetroPie-Setup/retropie_packages.sh mamelibretro
##sudo ~/RetroPie-Setup/retropie_packages.sh mednafenpcefast
##sudo ~/RetroPie-Setup/retropie_packages.sh mupen64plus-libretro
##sudo ~/RetroPie-Setup/retropie_packages.sh neslibretro
##sudo ~/RetroPie-Setup/retropie_packages.sh picodrive
##sudo ~/RetroPie-Setup/retropie_packages.sh pocketsnes
##sudo ~/RetroPie-Setup/retropie_packages.sh psxlibretro
##sudo ~/RetroPie-Setup/retropie_packages.sh stellalibretro
##sudo ~/RetroPie-Setup/retropie_packages.sh turbografx16
#
#cowsay -f stegosaurus Updating SNES emulators...
##sudo ~/RetroPie-Setup/retropie_packages.sh pisnes
##sudo ~/RetroPie-Setup/retropie_packages.sh snes9x
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-armsnes
##sudo ~/RetroPie-Setup/retropie_packages.sh pocketsnes
#sudo ~/RetroPie-Setup/retropie_packages.sh lr-catsfc
#
#cowsay -f stegosaurus Updating DOS emulators...
#sudo ~/RetroPie-Setup/retropie_packages.sh rpix86
#sudo ~/RetroPie-Setup/retropie_packages.sh dosbox
#
##sudo ~/RetroPie-Setup/retropie_packages.sh fastdosbox
#
##cowsay -f stegosaurus Updating Atari emulators...
##sudo ~/RetroPie-Setup/retropie_packages.sh hatari
#
##cowsay -f stegosaurus Updating Genesis emulators...
##sudo ~/RetroPie-Setup/retropie_packages.sh dgen
##sudo ~/RetroPie-Setup/retropie_packages.sh picodrive
#
##cowsay -f stegosaurus Updating Intellivision emulators...
##sudo ~/RetroPie-Setup/retropie_packages.sh jzintv
#
##cowsay -f stegosaurus Updating MSX emulators...
##sudo ~/RetroPie-Setup/retropie_packages.sh openmsx
##cowsay -f stegosaurus Updating GameGear emulators...
##sudo ~/RetroPie-Setup/retropie_packages.sh osmose
#
##cowsay -f elephant Updating the LinApple Apple 2 emulator...
##sudo ~/RetroPie-Setup/retropie_packages.sh linapple
#
##cowsay -f stegosaurus Updating MAME emulators...
##sudo ~/RetroPie-Setup/retropie_packages.sh advmame
##cowsay -f stegosaurus Updating MAME emulators...
###sudo ~/RetroPie-Setup/retropie_packages.sh advmame
###sudo ~/RetroPie-Setup/retropie_packages.sh mame4all
##sudo ~/RetroPie-Setup/retropie_packages.sh mamelibretro
#
##cowsay -f stegosaurus Updating Amiga emulators...
##sudo ~/RetroPie-Setup/retropie_packages.sh uae4all
#
##Currently breaks C64 emulator and doesn't build the replacement one yet
##installC64emulator.sh
#
#cowsay -f stegosaurus Updating other emulators...
#sudo ~/RetroPie-Setup/retropie_packages.sh zmachine
##sudo ~/RetroPie-Setup/retropie_packages.sh cpc
##sudo ~/RetroPie-Setup/retropie_packages.sh vice
##sudo ~/RetroPie-Setup/retropie_packages.sh basilisk
#
#cowsay -f elephant Updating various RPi PORTS...
#sudo ~/RetroPie-Setup/retropie_packages.sh darkplaces
#sudo ~/RetroPie-Setup/retropie_packages.sh xbmc
#cowsay -f stegosaurus Updating Minecraft...
#sudo ~/RetroPie-Setup/retropie_packages.sh minecraft
#sudo ~/RetroPie-Setup/retropie_packages.sh limelight
#sudo ~/RetroPie-Setup/retropie_packages.sh reicast

#cowsay -f stegosaurus Installing LXDE windowed mode - startx...
#installWindowedModeLxde.sh

cowsay Installing awesome PrimestationOne tools and ports...
installMegaTools.sh
#installDescent1and2.sh

cowsay -f stegosaurus Now installing things that will require your attention with prompting...

cowsay -f stegosaurus Updating PS3 RetroNetPlay...
sudo ~/RetroPie-Setup/retropie_packages.sh retronetplay

# cowsay -f stegosaurus Installing Limelight streamer...
# sudo ~/RetroPie-Setup/retropie_packages.sh limelight

cowsay -f stegosaurus Updating PS3 controller driver...
installPs3RecommendedDriver.sh
