#!/bin/bash


#Index/ID:                 Description:                                 List of available actions
#-----------------------------------------------------------------------------------------------------------------------------------
#100/advmame             : AdvanceMAME                                : depends sources build install configure
#101/ags                 : Adventure Game Studio - Adventure game engine : depends sources build install configure
#102/atari800            : Atari 8-bit/800/5200 emulator              : depends sources build install configure
#103/basilisk            : Macintosh emulator                         : depends sources build install configure
#104/cpc                 : Amstrad CPC emulator                       : sources build install configure
#105/dgen                : Megadrive/Genesis emulat. DGEN             : depends sources build install configure
#106/dosbox              : DOS emulator                               : depends sources build install configure
#107/fbzx                : ZXSpectrum emulator FBZX                   : sources build install configure
#108/frotz               : Z-Machine Interpreter for Infocom games    : install configure
#109/fuse                : ZX Spectrum emulator Fuse                  : depends sources build install configure
#110/gngeopi             : NeoGeo emulator GnGeoPi                    : depends sources build install configure
#111/gpsp                : GameBoy Advance emulator                   : depends sources build install configure
#112/hatari              : Atari emulator Hatari                      : depends sources build install configure
#113/jzintv              : Intellivision emulator                     : depends sources build install configure
#114/linapple            : Apple 2 emulator LinApple                  : depends sources build install configure
#115/mame4all            : MAME emulator MAME4All-Pi                  : depends sources build install configure
#116/mupen64plus         : N64 emulator MUPEN64Plus                   : depends sources build install configure
#117/mupen64plus-testing : N64 emulator MUPEN64Plus (Testing)         : depends sources build install configure
#118/openmsx             : MSX emulator OpenMSX                       : depends sources build install configure
#119/osmose              : Gamegear emulator Osmose                   : sources build install configure
#120/pcsx-rearmed        : Playstation emulator - PCSX (arm optimised) : depends sources build install configure
#121/pifba               : FBA emulator PiFBA                         : depends sources build install configure
#122/pisnes              : SNES emulator PiSNES                       : sources build install configure
#123/reicast             : Dreamcast emulator Reicast                 : depends sources build install configure
#124/retroarch           : RetroArch                                  : depends sources build install configure
#125/rpix86              : DOS Emulator rpix86                        : install configure
#126/scummvm             : ScummVM                                    : depends sources build install configure
#127/snes9x              : SNES emulator SNES9X-RPi                   : depends sources build install configure
#128/stella              : Atari2600 emulator STELLA                  : install configure
#129/uae4all             : Amiga emulator UAE4All                     : depends sources build install configure
#130/vice                : C64 emulator VICE                          : depends sources build install configure
#200/lr-4do              : 3DO emu - 4DO/libfreedo port for libretro  : sources build install configure
#201/lr-armsnes          : SNES emu - forked from pocketsnes focused on performance : sources build install configure
#202/lr-beetle-vb        : Virtual Boy emulator - Mednafen VB (optimised) port for libretro : sources build install configure
#203/lr-catsfc           : SNES emu - CATSFC based on Snes9x / NDSSFC / BAGSFC : sources build install configure
#204/lr-desmume          : NDS emu - DESMUME                          : sources build install configure
#205/lr-fba              : Arcade emu - Final Burn Alpha port for libretro : depends sources build install configure
#206/lr-fceumm           : NES emu - FCEUmm port for libretro         : sources build install configure
#207/lr-fmsx             : MSX/MSX2 emu - fMSX port for libretro      : sources build install configure
#208/lr-gambatte         : Gameboy Color emu - libgambatte port for libretro : sources build install configure
#209/lr-genesis-plus-gx  : Sega 8/16 bit emu - Genesis Plus (enhanced) port for libretro : sources build install configure
#210/lr-gpsp             : GBA emu - gpSP port for libretro           : sources build install configure
#211/lr-handy            : Atari Lynx emulator - Handy port for libretro : sources build install configure
#212/lr-imame4all        : Arcade emu - iMAME4all (based on MAME 0.37b5) port for libretro : sources build install configure
#213/lr-mednafen-pce-fast: PCEngine emu - Mednafen PCE Fast port for libretro : sources build install configure
#214/lr-mednafen-pce     : PCEngine emu - Mednafen PCE core port for libretro : sources build install configure
#215/lr-mgba             : GBA emulator - MGBA (optimised) port for libretro : sources build install configure
#216/lr-mupen64plus      : N64 emu - Mupen64 Plus port for libretro   : sources build install configure
#217/lr-nestopia         : NES emu - Nestopia (enhanced) port for libretro : sources build install configure
#218/lr-nxengine         : Cave Story engine clone - NxEngine port for libretro : sources build install configure
#219/lr-o2em             : Odyssey 2 / Videopac emu - O2EM port for libretro : sources build install configure
#220/lr-pcsx-rearmed     : Playstation emulator - PCSX (arm optimised) port for libretro : depends sources build install configure
#221/lr-picodrive        : Sega 8/16 bit emu - picodrive arm optimised libretro core : sources build install configure
#222/lr-pocketsnes       : SNES emu - ARM based SNES emulator for libretro : sources build install configure
#223/lr-prboom           : Doom/Doom II engine - PrBoom port for libretro : sources build install configure
#224/lr-prosystem        : Atari 7800 ProSystem emu - ProSystem port for libretro : sources build install configure
#225/lr-snes9x-next      : SNES emulator - Snes9x 1.52+ (optimised) port for libretro : sources build install configure
#226/lr-stella           : Atari 2600 emulator - Stella port for libretro : sources build install configure
#227/lr-tgbdual          : Gameboy Color emu - TGB Dual port for libretro : sources build install configure
#228/lr-tyrquake         : Quake 1 engine - Tyrquake port for libretro : depends sources build install configure
#229/lr-vba-next         : GBA emulator - VBA-M (optimised) port for libretro : sources build install configure
#230/lr-vecx             : Vectrex emulator - vecx port for libretro  : sources build install configure
#231/lr-virtualjaguar    : Atari Jaguar emu - Virtual Jaguar (optimised) port for libretro : sources build install configure
#232/lr-yabause          : Sega Saturn emu - Yabause (optimised) port for libretro : sources build install configure
#250/darkplaces          : Darkplaces Quake                           : depends sources install configure
#251/dxx-rebirth         : DXX-Rebirth (Descent & Descent 2) build from source : depends sources build install configure
#252/eduke32             : Duke3D Port                                : depends sources build install configure
#253/kodi                : Install Kodi                               : depends install configure
#254/minecraft           : Minecraft                                  : depends install configure
#255/quake3              : Quake 3                                    : depends sources build install configure
#300/aptpackages         : Update APT packages                        : install
#301/audiosettings       : Configure audio settings                   : configure
#302/autostartemustat    : Auto-start EmulationStation                : configure
#303/bashwelcometweak    : Bash Welcome Tweak (shows additional system info on login) : install configure remove
#304/disabletimeouts     : Disable system timeouts                    : install
#305/dispmanx            : Configure emulators to use dispmanx SDL    : configure
#306/emulationstation    : EmulationStation                           : depends sources build install configure
#307/esthemecolorpi      : EmulationStation Theme Color Pi            : install
#308/esthemesimple       : EmulationStation Theme Simple              : sources install
#309/esconfig            : ES-Config                                  : sources build install configure
#310/gamecondriver       : Gamecon & db9 drivers                      : install configure
#311/hotkey              : Change hotkey behaviour                    : configure
#312/limelight           : Limelight Game Streaming                   : depends sources install configure
#313/modules             : Modules UInput, Joydev, ALSA               : install
#314/packagecleanup      : Remove raspbian packages that are not needed for RetroPie : configure
#315/packagerepository   : Package Repository                         : install
#316/ps3controllerpairing: Pair PS3 controller                        : configure
#317/ps3controller       : Install PS3 controller driver              : depends sources build install configure
#318/resetromdirs        : Reset ownership/permissions of /home/pi/RetroPie/roms : configure
#319/retroarchautoconf   : RetroArch-AutoConfigs                      : sources install configure
#320/retroarchinput      : Configure input devices for RetroArch      : configure
#321/retronetplay        : RetroNetplay                               : configure
#322/retropiemenu        : RetroPie configuration menu for EmulationStation : depends configure
#323/runcommand          : Configure runcommand - Launch script       : install configure
#324/sambashares         : Samba ROM Shares                           : install configure
#325/sdl1                : SDL 1.2.15 with rpi fixes and dispmanx     : depends sources build install
#326/sdl2                : SDL (Simple DirectMedia Layer) v2.x        : depends sources build install
#327/snesdev             : SNESDev (Driver for the RetroPie GPIO-Adapter) : sources build install configure
#328/splashscreen        : Configure Splashscreen                     : depends configure
#329/usbromservice       : USB ROM Service                            : depends configure
#330/xarcade2jstick      : Xarcade2Jstick                             : sources build install configure
#331/xboxdrv             : Install XBox contr. 360 driver             : install
#900/createbinaries      : Create binary archives for distribution    : install
#901/setup               : GUI based setup for RetroPie               : depends configure
#===================================================================================================================================

retroPieNukeAndCheckoutFresh.sh

cowsay -f stegosaurus Now installing one thing that will require your attention with prompting at the end...

cowsay Installing RetroPie binaries...
installRetroPieBinaries.sh

echo Installing experimental emulators and such that dont require prompting...

sudo ~/RetroPie-Setup/retropie_packages.sh lr-4do
sudo ~/RetroPie-Setup/retropie_packages.sh lr-beetle-vb
sudo ~/RetroPie-Setup/retropie_packages.sh lr-mgba
sudo ~/RetroPie-Setup/retropie_packages.sh lr-vba-next
sudo ~/RetroPie-Setup/retropie_packages.sh lr-virtualjaguar
sudo ~/RetroPie-Setup/retropie_packages.sh lr-pcsx-rearmed
sudo ~/RetroPie-Setup/retropie_packages.sh lr-yabause
sudo ~/RetroPie-Setup/retropie_packages.sh lr-desmume
sudo ~/RetroPie-Setup/retropie_packages.sh lr-prboom
sudo ~/RetroPie-Setup/retropie_packages.sh lr-snes9x-next
sudo ~/RetroPie-Setup/retropie_packages.sh lr-prosystem
sudo ~/RetroPie-Setup/retropie_packages.sh lr-mupen64plus
sudo ~/RetroPie-Setup/retropie_packages.sh lr-dosbox
sudo ~/RetroPie-Setup/retropie_packages.sh mupen64plus
sudo ~/RetroPie-Setup/retropie_packages.sh mupen64plus-testing
sudo ~/RetroPie-Setup/retropie_packages.sh darkplaces
sudo ~/RetroPie-Setup/retropie_packages.sh kodi
sudo ~/RetroPie-Setup/retropie_packages.sh minecraft
sudo ~/RetroPie-Setup/retropie_packages.sh ags
sudo ~/RetroPie-Setup/retropie_packages.sh openmsx
sudo ~/RetroPie-Setup/retropie_packages.sh dxx-rebirth

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

cowsay -f stegosaurus Installing Limelight streamer...
sudo ~/RetroPie-Setup/retropie_packages.sh limelight

cowsay -f stegosaurus Updating PS3 controller driver...
installPs3RecommendedDriver.sh
