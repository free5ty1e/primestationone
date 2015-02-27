#!/bin/bash

cowsay -f mech-and-cow Updating RetroPie packages specific to the RetroPie...
sudo ~/RetroPie-Setup/retropie_packages.sh aptpackages

cowsay -f mech-and-cow Updating RetroPie packages specific to the PrimeStation One...
cowsay -f elephant Installing required module packagerepository
sudo ~/RetroPie-Setup/retropie_packages.sh packagerepository
cowsay -f elephant Installing required modules UInput, JoyDev, ALSA
sudo ~/RetroPie-Setup/retropie_packages.sh modules
cowsay -f elephant Installing required module runcommand
sudo ~/RetroPie-Setup/retropie_packages.sh runcommand

cowsay -f elephant Installing roms folder sharing module sambashares
sudo ~/RetroPie-Setup/retropie_packages.sh sambashares

cowsay -f stegosaurus Updating retroarch joypad autoconfigs...
sudo ~/RetroPie-Setup/retropie_packages.sh retroarchautoconf
sudo ~/RetroPie-Setup/retropie_packages.sh retroarchjoypadautoconf
sudo ~/RetroPie-Setup/retropie_packages.sh esconfig

#Included with retropie image:
#doom  Doom 1 Shareware.sh  duke3d  Duke3D Shareware.sh  quake  Quake III Arena.sh  Quake.sh

cowsay -f stegosaurus Installing missing ports and emulators...
sudo ~/RetroPie-Setup/retropie_packages.sh 4do
sudo ~/RetroPie-Setup/retropie_packages.sh o2em
sudo ~/RetroPie-Setup/retropie_packages.sh cavestory
sudo ~/RetroPie-Setup/retropie_packages.sh libretro-vecx
sudo ~/RetroPie-Setup/retropie_packages.sh tyrquake

#sudo ~/RetroPie-Setup/retropie_packages.sh armsnes
#sudo ~/RetroPie-Setup/retropie_packages.sh catsfc
#sudo ~/RetroPie-Setup/retropie_packages.sh fbalibretro
#sudo ~/RetroPie-Setup/retropie_packages.sh fmsx-libretro
#sudo ~/RetroPie-Setup/retropie_packages.sh gbclibretro
#sudo ~/RetroPie-Setup/retropie_packages.sh genesislibretro
#sudo ~/RetroPie-Setup/retropie_packages.sh libretro-handy
#sudo ~/RetroPie-Setup/retropie_packages.sh mamelibretro
#sudo ~/RetroPie-Setup/retropie_packages.sh mednafenpcefast
#sudo ~/RetroPie-Setup/retropie_packages.sh mupen64plus-libretro
#sudo ~/RetroPie-Setup/retropie_packages.sh neslibretro
#sudo ~/RetroPie-Setup/retropie_packages.sh nestopia
#sudo ~/RetroPie-Setup/retropie_packages.sh picodrive
#sudo ~/RetroPie-Setup/retropie_packages.sh pocketsnes
#sudo ~/RetroPie-Setup/retropie_packages.sh psxlibretro
#sudo ~/RetroPie-Setup/retropie_packages.sh stellalibretro
#sudo ~/RetroPie-Setup/retropie_packages.sh turbografx16

#cowsay -f stegosaurus Updating SNES emulators...
#sudo ~/RetroPie-Setup/retropie_packages.sh pisnes
#sudo ~/RetroPie-Setup/retropie_packages.sh snes9x
#sudo ~/RetroPie-Setup/retropie_packages.sh armsnes
#sudo ~/RetroPie-Setup/retropie_packages.sh pocketsnes
#sudo ~/RetroPie-Setup/retropie_packages.sh catsfc

cowsay -f stegosaurus Updating DOS emulators...
sudo ~/RetroPie-Setup/retropie_packages.sh rpix86
#sudo ~/RetroPie-Setup/retropie_packages.sh dosbox

#sudo ~/RetroPie-Setup/retropie_packages.sh fastdosbox

#cowsay -f stegosaurus Updating Atari emulators...
#sudo ~/RetroPie-Setup/retropie_packages.sh hatari

#cowsay -f stegosaurus Updating Genesis emulators...
#sudo ~/RetroPie-Setup/retropie_packages.sh dgen
#sudo ~/RetroPie-Setup/retropie_packages.sh picodrive

#cowsay -f stegosaurus Updating Intellivision emulators...
#sudo ~/RetroPie-Setup/retropie_packages.sh jzintv

#cowsay -f stegosaurus Updating MSX emulators...
#sudo ~/RetroPie-Setup/retropie_packages.sh openmsx
#cowsay -f stegosaurus Updating GameGear emulators...
#sudo ~/RetroPie-Setup/retropie_packages.sh osmose

#cowsay -f elephant Updating the LinApple Apple 2 emulator...
#sudo ~/RetroPie-Setup/retropie_packages.sh linapple

#cowsay -f stegosaurus Updating MAME emulators...
#sudo ~/RetroPie-Setup/retropie_packages.sh advmame
#cowsay -f stegosaurus Updating MAME emulators...
##sudo ~/RetroPie-Setup/retropie_packages.sh advmame
##sudo ~/RetroPie-Setup/retropie_packages.sh mame4all
#sudo ~/RetroPie-Setup/retropie_packages.sh mamelibretro

#cowsay -f stegosaurus Updating Amiga emulators...
#sudo ~/RetroPie-Setup/retropie_packages.sh uae4all

#Currently breaks C64 emulator and doesn't build the replacement one yet
#installC64emulator.sh

cowsay -f stegosaurus Updating other emulators...
sudo ~/RetroPie-Setup/retropie_packages.sh zmachine
#sudo ~/RetroPie-Setup/retropie_packages.sh cpc
#sudo ~/RetroPie-Setup/retropie_packages.sh vice
#sudo ~/RetroPie-Setup/retropie_packages.sh basilisk

cowsay -f elephant Updating various RPi PORTS...
sudo ~/RetroPie-Setup/retropie_packages.sh darkplaces
sudo ~/RetroPie-Setup/retropie_packages.sh xbmc
cowsay -f stegosaurus Updating Minecraft...
sudo ~/RetroPie-Setup/retropie_packages.sh minecraft

cowsay -f stegosaurus Installing LXDE windowed mode - startx...
installWindowedModeLxde.sh

cowsay -f stegosaurus Updating PS3 controller driver...
sudo ~/RetroPie-Setup/retropie_packages.sh ps3controller

cowsay -f stegosaurus Updating PS3 RetroNetPlay...
sudo ~/RetroPie-Setup/retropie_packages.sh retronetplay
