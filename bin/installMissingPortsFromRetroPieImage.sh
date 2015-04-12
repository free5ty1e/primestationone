#!/bin/bash


#Index/ID:                 Description:                                 List of available actions
#-----------------------------------------------------------------------------------------------------------------------------------
#100/advmame             : AdvanceMAME                                : depends sources build install configure
#101/atari800            : Atari 800 emulator                         : depends sources build install configure
#102/basilisk            : Macintosh emulator                         : depends sources build install configure
#103/cpc                 : Amstrad CPC emulator                       : sources build install configure
#104/dgen                : Megadrive/Genesis emulat. DGEN             : depends sources build install configure
#105/dosbox              : DOS emulator                               : depends sources build install configure
#106/fbzx                : ZXSpectrum emulator FBZX                   : sources build install configure
#107/fuse                : ZX Spectrum emulator Fuse                  : depends sources build install configure
#108/gngeopi             : NeoGeo emulator GnGeoPi                    : depends sources build install configure
#109/gpsp                : GameBoy Advance emulator                   : depends sources build install configure
#110/hatari              : Atari emulator Hatari                      : depends sources build install configure
#111/jzintv              : Intellivision emulator                     : depends sources build install configure
#112/linapple            : Apple 2 emulator Linapple                  : depends sources build install configure
#113/mame4all            : MAME emulator MAME4All-Pi                  : depends sources build install configure
#114/mupen64plus         : N64 emulator MUPEN64Plus                   : depends sources build install configure
#115/mupen64plus-testing : N64 emulator MUPEN64Plus (Testing)         : depends sources build install configure
#116/openmsx             : MSX emulator OpenMSX                       : depends sources build install configure
#117/osmose              : Gamegear emulator Osmose                   : sources build install configure
#118/pifba               : FBA emulator PiFBA                         : depends sources build install configure
#119/pisnes              : SNES emulator PiSNES                       : sources build install configure
#120/retroarch           : RetroArch                                  : depends sources build install configure
#121/rpix86              : DOS Emulator rpix86                        : install configure
#122/scummvm             : ScummVM                                    : depends sources build install configure
#123/snes9x              : SNES emulator SNES9X-RPi                   : depends sources build install configure
#124/stella              : Atari2600 emulator STELLA                  : install configure
#125/uae4all             : Amiga emulator UAE4All                     : depends sources build install configure
#126/vice                : C64 emulator VICE                          : depends sources build install configure
#127/zmachine            : ZMachine                                   : install
#200/lr-4do              : 3DO emu - 4DO/libfreedo port for libretro  : sources build install configure
#201/lr-armsnes          : SNES emu - forked from pocketsnes focused on performance : sources build install configure
#202/lr-catsfc           : SNES emu - CATSFC based on Snes9x / NDSSFC / BAGSFC : sources build install configure
#203/lr-fba              : Arcade emu - Final Burn Alpha port for libretro : depends sources build install configure
#204/lr-fceu-next        : NES emu - FCEUmm / FCEUX NES port for libretro : sources build install configure
#205/lr-fmsx             : MSX/MSX2 emu - fMSX port for libretro      : sources build install configure
#206/lr-gambatte         : Gameboy Color emu - libgambatte port for libretro : sources build install configure
#207/lr-genesis-plus-gx  : Sega 8/16 bit emu - Genesis Plus (enhanced) port for libretro : sources build install configure
#208/lr-gpsp             : GBA emu - gpSP port for libretro           : sources build install configure
#209/lr-handy            : Atari Lynx emulator - Handy port for libretro : sources build install configure
#210/lr-imame4all        : Arcade emu - iMAME4all (based on MAME 0.37b5) port for libretro : sources build install configure
#211/lr-mednafen-pce-fast: PCEngine emu - Mednafen PCE Fast port for libretro : sources build install configure
#212/lr-mednafen-pce     : PCEngine emu - Mednafen PCE core port for libretro : sources build install configure
#213/lr-mupen64plus      : N64 emu - Mupen64 Plus port for libretro   : sources build install configure
#214/lr-nestopia         : NES emu - Nestopia (enhanced) port for libretro : sources build install configure
#215/lr-nxengine         : Cave Story engine clone - NxEngine port for libretro : sources build install configure
#216/lr-o2em             : Odyssey 2 emulator - O2EM port for libretro : sources build install configure
#217/lr-pcsx-rearmed     : Playstation emulator - PCSX (arm optimised) port for libretro : depends sources build install configure
#218/lr-picodrive        : Sega 8/16 bit emu - picodrive arm optimised libretro core : sources build install configure
#219/lr-pocketsnes       : SNES emu - ARM based SNES emulator for libretro : sources build install configure
#220/lr-prboom           : Doom/Doom II engine - PrBoom port for libretro : sources build install configure
#222/lr-stella           : Atari 2600 emulator - Stella port for libretro : sources build install configure
#223/lr-tyrquake         : Quake 1 engine - Tyrquake port for libretro : depends sources build install configure
#225/lr-vecx             : Vectrex emulator - vecx port for libretro  : sources build install configure
#250/darkplaces          : Darkplaces Quake                           : depends sources install configure
#251/eduke32             : Duke3D Port                                : depends sources build install configure
#252/kodi                : Install Kodi                               : depends install configure
#253/minecraft           : Minecraft                                  : install configure
#254/quake3              : Quake 3                                    : depends sources build install configure
#300/aptpackages         : Update APT packages                        : install
#301/audiosettings       : Configure audio settings                   : configure
#302/autostartemustat    : Auto-start EmulationStation                : configure
#303/bashwelcometweak    : Bash Welcome Tweak (shows additional system info on login) : install configure remove
#304/disabletimeouts     : Disable system timeouts                    : install
#305/dispmanx            : Configure emulators to use dispmanx SDL    : configure
#306/emulationstation    : EmulationStation                           : depends sources build install configure
#307/esthemesimple       : EmulationStation Theme Simple              : install
#308/esconfig            : ES-Config                                  : sources build install configure
#309/gamecondriver       : Gamecon driver                             : install configure
#310/hotkey              : Change hotkey behaviour                    : configure
#311/modules             : Modules UInput, Joydev, ALSA               : install
#312/packagecleanup      : Remove raspbian packages that are not needed for RetroPie : configure
#313/packagerepository   : Package Repository                         : install
#314/ps3controller       : Install PS3 controller driver              : depends sources build install configure
#315/resetromdirs        : Reset ownership/permissions of /home/pi/RetroPie/roms : configure
#316/retroarchautoconf   : RetroArch-AutoConfigs                      : sources install configure
#317/retroarchjoyconfig  : Register RetroArch controller              : configure
#318/retronetplay        : RetroNetplay                               : configure
#319/retropiemenu        : RetroPie configuration menu for EmulationStation : depends configure
#320/runcommand          : Configure runcommand - Launch script       : install configure
#321/sambashares         : Samba ROM Shares                           : install configure
#322/sdl1                : SDL 1.2.15 with rpi fixes and dispmanx     : depends sources build install
#323/sdl2                : SDL (Simple DirectMedia Layer) v2.x        : depends sources build install
#324/snesdev             : SNESDev (Driver for the RetroPie GPIO-Adapter) : sources build install configure
#325/splashscreen        : Configure Splashscreen                     : depends configure
#326/usbromservice       : USB ROM Service                            : depends configure
#327/xarcade2jstick      : Xarcade2Jstick                             : sources build install configure
#328/xboxdrv             : Install XBox contr. 360 driver             : install
#900/createbinaries      : Create binary archives for distribution    : install
#901/setup               : GUI based setup for RetroPie               : depends configure
#===================================================================================================================================

installRetroPieBinaries.sh

echo Installing experimental emulators and such that dont require prompting...

sudo ~/RetroPie-Setup/retropie_packages.sh lr-4do
sudo ~/RetroPie-Setup/retropie_packages.sh lr-beetle-vb
sudo ~/RetroPie-Setup/retropie_packages.sh lr-mgba
sudo ~/RetroPie-Setup/retropie_packages.sh lr-vba-next
sudo ~/RetroPie-Setup/retropie_packages.sh lr-virtualjaguar
sudo ~/RetroPie-Setup/retropie_packages.sh lr-pcsx-rearmed
sudo ~/RetroPie-Setup/retropie_packages.sh lr-yabause
sudo ~/RetroPie-Setup/retropie_packages.sh lr-prboom
sudo ~/RetroPie-Setup/retropie_packages.sh lr-snes9x-next
sudo ~/RetroPie-Setup/retropie_packages.sh lr-prosystem
sudo ~/RetroPie-Setup/retropie_packages.sh lr-mupen64plus
sudo ~/RetroPie-Setup/retropie_packages.sh mupen64plus
sudo ~/RetroPie-Setup/retropie_packages.sh mupen64plus-testing
sudo ~/RetroPie-Setup/retropie_packages.sh darkplaces
sudo ~/RetroPie-Setup/retropie_packages.sh kodi
sudo ~/RetroPie-Setup/retropie_packages.sh minecraft
sudo ~/RetroPie-Setup/retropie_packages.sh ags
sudo ~/RetroPie-Setup/retropie_packages.sh openmsx
sudo ~/RetroPie-Setup/retropie_packages.sh reicast


sudo ~/RetroPie-Setup/retropie_packages.sh inputstation

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

cowsay -f stegosaurus Installing LXDE windowed mode - startx...
installWindowedModeLxde.sh

#cowsay -f stegosaurus Updating PS3 controller driver...
#sudo ~/RetroPie-Setup/retropie_packages.sh ps3controller
#Installing our PS3 controller driver just in case the RetroPie one is still busted...
#installPs3BluetoothDaemon.sh
#installBluezPs3Driver.sh

cowsay -f stegosaurus Updating PS3 RetroNetPlay...
sudo ~/RetroPie-Setup/retropie_packages.sh retronetplay
