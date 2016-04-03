# PrimeStation One
## A Set of Scripts and Tools For a "Ready-To-Go" [RetroPie](https://github.com/petrockblog/RetroPie-Setup) 

### A Recent PS3 Controller Layout / Quick Reference: 
![SplashScreen](http://i.imgur.com/QzpV4K9.png)
http://i.imgur.com/QzpV4K9.png

The point of the Primestation One is to be able to massively retrogame from the comfort of your couch on minimal hardware, without getting up to change cartridges or discs or controllers or wiring or inputs, with optional netplay capabilities.

* For Raspberry Pi 1,2, and 3 - minimum Pi2 recommended for full compatibility (N64 and PSX are unplayable on Pi1, several systems unavailable on Pi1 -- Dreamcast, Saturn, SNES Mouse, etc)
* PS3 sixaxis controller controls ready and configured to work with Bluetooth or USB on multiple games and game system emulations
* 100 separate and easily-accessible save states per game
* Rewind feature turns all retro games into Braid or Prince Of Persia: Sands of Time and is togglable per system
* Cloud save and save state backup to mega.co.nz
* Support for the SNES Mouse / Mario Paint with easy launch
* Easy pairing scripts for bluetooth keyboards and mice
* Automatic PS3-like pairing routine for controllers (plug in PS3 controller via USB for ~5 seconds, unplug and then can connect via bluetooth until a real PS3 or different Bluetooth adapter is paired).  

##### Current recommended, reasonably-priced buildout through Amazon Prime (minus *GENUINE* SONY PS3 controller):
* http://amzn.com/B008XVAVAW - Raspberry Pi 2 complete starter kit
* http://amzn.com/B00JN5SLHC - Bluetooth adapter
* http://amzn.com/B00M55C0NS - 32GB SD card for maximum gameage
* http://amzn.com/B00M55C1I2 - OR 64GB SD card for even more maximum gameage (PlayStation1 and Dreamcast ROMS are not small!)

#### Primestation pre-built image downloads (details and instructions below): http://goo.gl/RPKAr1

#### PrimeStation One Control / Convenience App for Android github repo: 
*[![Build Status](https://travis-ci.org/free5ty1e/primestationone-control-android.svg?branch=master)](https://travis-ci.org/free5ty1e/primestationone-control-android)
* https://github.com/free5ty1e/primestationone-control-android
* Download from the Play Store:
* [![QR Code For Play Store](https://raw.githubusercontent.com/free5ty1e/primestationone-control-android/master/app/src/main/res/drawable-nodpi/qrcode.png)](https://play.google.com/store/apps/details?id=com.chrisprime.primestationonecontrol)
* https://play.google.com/store/apps/details?id=com.chrisprime.primestationonecontrol

##### PrimeStation One Quick Setup and Gaming Montage (extremely amateur) video: https://www.youtube.com/watch?v=70sQS6AAMNU

##### Other helpful links / organized documentation:
* PrimeStation One theme for EmulationStation github repo:
https://github.com/free5ty1e/primestationone-estheme
* PrimeStation One fork of qtsixad PS3 controller driver source code:
https://github.com/free5ty1e/qtsixa
* Transferring Primestation to run directly on USB instead of SD: https://github.com/free5ty1e/primestationone/blob/master/reference/txt/usbinstall.md
* Installing fresh and / or building from sources: https://github.com/free5ty1e/primestationone/blob/master/reference/txt/installfresh.md
* Changelog: https://github.com/free5ty1e/primestationone/blob/master/reference/txt/changelog.md
* TROUBLESHOOTING: https://github.com/free5ty1e/primestationone/blob/master/reference/txt/troubleshooting.md


#### Officially supported systems on the PrimeStation One, running full speed:
* Atari 800, 2600, 5200, ST / Falcon, Lynx
* Nintendo Entertainment System (NES)
* Game Boy and Game Boy Color
* Super NES (SNES), including Mario Paint with USB mouse support
* Sony Playstation One (PSX / PS1)
* Sega Master System, SG-1000, Genesis / Megadrive, Sega CD, 32x
* Commodore 64, Amiga 500 / 1000 / 1500 / etc
* Neo Geo
* MAME (specifically for older MAME 37b5 ROMS)
* MSX
* TurboGrafx-16 (PC-Engine)
* DOS / IBM-PC / MS-DOS
* Infocom ZMachine (Zork I, II, III)
* SCUMMVM (for many DOS adventure games such as Day of the Tentacle)
* Apple ][, Macintosh Classic (Up to OS 8)
* Sinclair ZX Spectrum
* Intellivision
* Amstrad CPC

##### Included Raspberry Pi native shareware / freeware games (ports):
* Doom 
* Quake
* Quake 3 Arena
* Duke Nukem 3D
* Cave Story
* Angband
* Descent 1
* Descent 2

##### Included but experimental on the PrimeStation One (under development, not full speed on some or all games, etc):
* Atari 7800 Prosystem
* Atari Jaguar
* Nintendo 64
* Sega Saturn
* Sega Dreamcast

=============
####Please Note: The PrimeStation One's main driving force is to do ALL THE THINGS!
=============

## INSTALLATION AND FIRST RUN
###  Download the latest primeStationOne image archive (and any other modules / tools you are interested in) from the following MEGA (mega.co.nz) share: http://goo.gl/RPKAr1

If you have managed to obtain one of these releases, extract the .7z archive so you have the .img file.  

Here are the commands to write the image file on Mac and Linux with a progress bar as well.  The v0.9998 beta release archive is used for this example, adjust accordingly if you have a different version.  You will need a minimum of a 4GB SD card to begin using the PrimeStation One.  Once (and if) you've transferred the root filesystem to USB, you can manually prepare a tiny SD card (any size above 50 MB will work) to act as a boot drive for the USB PrimeStation and free up your 4GB SD card for other uses.

####Install on Mac: (UPDATE: You can also probably use ApplePi Baker @ http://www.tweaking4all.com/hardware/raspberry-pi/macosx-apple-pi-baker/ ) (`brew install pv` if you don't have pv.  If you don't have Homebrew, go to http://brew.sh/ and follow the instructions)   Replace the device `/dev/disk2` with your SD card designation (disk1, disk2, disk3...).
```
        pv --size 3960734720 primeStationOne3.9gSdV0.9998betaBasedOnRetroPie3.0.0beta2RPi1.img | sudo dd bs=2m of=/dev/disk2
```
...or, I suppose you COULD do it without pv and just watch a blank cursor and guess how fast it is transferring and how far along it is and how much longer it will be, by typing:
```
        sudo dd bs=2m if=primeStationOne3.9gSdV0.9998betaBasedOnRetroPie3.0.0beta2RPi1.img of=/dev/disk2
```


####Install on Linux: (`sudo apt-get install pv` if you don't have pv)  Replace the device `/dev/sdb` with your SD card designation (sda, sdb, sdc...).
```
        pv --size 3960734720 primeStationOne3.9gSdV0.9998betaBasedOnRetroPie3.0.0beta2RPi1.img | sudo dd bs=2M of=/dev/sdb
```
...or, I suppose you COULD do it without pv and just watch a blank cursor and guess how fast it is transferring and how far along it is and how much longer it will be, by typing:
```
        sudo dd bs=2M if=primeStationOne3.9gSdV0.9998betaBasedOnRetroPie3.0.0beta2RPi1.img of=/dev/sdb
```

####Install on Windows: Follow this instruction.

Go here for Windows install instructions
http://www.raspberrypi.org/documentation/installation/installing-images/windows.md


### First time running PrimeStation One from ready-to-go 8GB SD card image
Starting with v1.0000alpha, the full-featured 8GB SD card image (if available) is ready to use (and also the only way to go now)!  

First, decide if you want to run the PrimeStation One from the SD card only or do you have a USB drive you'd like to dedicate to the system?  

1. Either expand SD filesystem to fill your SD card (`sudo raspi-config` -> Expand Filesystem, also feel free to Overclock your Pi here if you have heat sinks or fans) or transfer root filesystem to USB (`usbRootFilesystemSetup.sh` and follow the instructions when prompted)
2. Reboot

#### Expanding your SD filesystem to fill your SD card
...this is the "normal" method of running a Raspberry Pi, directly and only from an SD card.  SD card space is typically slower and more expensive when compared to USB storage, and it's great to have more space for ROMs, so we recommend you follow the next section and transfer your root filesystem to a dedicated USB drive.  However, if you'd prefer to run off SD only, simply run the following command:
```
sudo raspi-config
```
...select `Expand Filesystem` from the menu, exit, and follow the prompt to reboot your Pi.  This ONLY works for SD card root filesystems.



#### Netplay for RetroArch / LibRetroCore-enabled emulators
As of v0.976, a handy netplay configuration / enable / disable script is provided on the EmulationStation settings page!
Or, you can type `netplayConfigForRetroArchLibretrocoreEmulators.sh` to launch from the terminal.

From here, you can enable / disable and configure netplay functionality on libretrocore enabled emulators, a list of which is located in the repository here: [!ListOfNetplayEmus](http://raw.githubusercontent.com/free5ty1e/primestationone/master/reference/txt/listOfLibRetroCores.txt)

#### Cloud Save Game and Save State Backup
As of v0.9999, the Primestation One has the capability to link to a Mega.co.nz cloud drive for save state and save game backup / restore purposes.  Never lose your precious saves again!

In the EmulationStation `Settings` page (the start-up page), scroll down to the `cloudBackup` folder and look inside for the (hopefully self-explanatory) scripts you will need:

```
mega_cloud_login.sh
mega_cloud_clear_login.sh
mega_cloud_backup_all_savestates_and_srams.sh
mega_cloud_restore_all_savestates_and_srams.sh
```


### Playing Mario Paint on SNES with the Mouse
...can be achieved, but only on a Pi2 or Pi3 as it requires the `*Super Nintendo - SNES9xNextPi2` emulator (4th Super Nintendo emulator listed when pressing `right` to browse from the starting point).

Since V0.9999, the Snes Mouse has it's own emulation entry just for Mario Paint, to avoid having to do any of the below!  There is a new rom folder `~/RetroPie/roms/snesmouse` to place your Mario Paint and any other SNES Mouse roms in.  (Must put a ROM in the `snesmouse` folder before this new entry will show up in Emulationstation)

1. Navigate to this SNES emulator, find your Mario Paint ROM, and launch it.
2. Bring up the RetroArch menu (On PS3 controller: hold `SELECT` and press `L1`, on keyboard should just be `F1`)
3. Press the `CIRCLE` button on the PS3 controller to continue
4. Navigate to `Settings` and press `CIRCLE` to continue
5. Navigate to `Input Settings - Joypad Mapping` and press `CIRCLE` to continue
6. Navigate to `User 1 Device Type` and press `right` to change `SNES Joypad` to `SNES Mouse`.  
7. Exit the RetroArch menu (On PS3 controller: hold `SELECT` and press `L1`, on keyboard should just be `F1`)
8. You should now have SNES Mouse control over Mario Paint!!  You are welcome.   --Prime


##### NETPLAY -- IMPORTANT!:
When launching an emulator capable of NETPLAY, you must hit the `x` key pretty much immediately after emulationstation's interface dissappears; there is a brief prompt asking you to press this key for options.  You need to go to this menu and choose the `Launch with netplay support` (or hotkey `z`) then `ENTER` to actually launch the emulator with your netplay settings enabled.  

If you start in Host mode, your emulator will appear to *freeze* during startup until a Client connects.

Start your host first, then start the client(s).  You can watch them connect and the screens sync up.  Awesome!!

There is also a button combination mapped on the controller to allow you to swap netplayers, though this is experimental.  Look for it on the splashscreen / quick reference screen (also above) and try it out!


## FUTURE
All plans for future enhancements are now documented as individual Primestation One issues, labeled as `Enhancements` and prefixed with `FEATURE:` 

Comments / suggestions / contributions to the code welcome!  

### CREDITS
* Chris "Prime" Paiano (Founder, Lead Developer) - Twitter: @ChrisPaiano https://twitter.com/ChrisPrimeish
* "Circuit Static" (User Experience, Quality, Development & Marketing) - Twitter: @circuitStatic https://twitter.com/circuitStatic

....

#### Standing on the Shoulders of Giants 
(Wouldn't have been possible, or at least nearly this easy, without the following...)
* RetroPie project (https://github.com/petrockblog/RetroPie-Setup)
* QtSixA project (http://qtsixa.sourceforge.net/)
