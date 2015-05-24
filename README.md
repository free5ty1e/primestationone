# PrimeStation One
## A Set of Scripts and Tools For a "Ready-To-Go" [RetroPie](https://github.com/petrockblog/RetroPie-Setup) 

### A Recent PS3 Controller Layout / Quick Reference: 
![SplashScreen](http://i.imgur.com/Rvp4Gup.png)
http://i.imgur.com/Rvp4Gup.png

The point of the Primestation One is to be able to massively retrogame from the comfort of your couch on minimal hardware, without getting up to change cartridges or discs or controllers or wiring or inputs, with optional netplay capabilities.

* For Raspberry Pi 1 and 2, Pi2 recommended for full compatibility (N64 and PSX are unplayable on Pi1, several systems unavailable on Pi1 -- Dreamcast, Saturn, SNES Mouse, etc)
* PS3 sixaxis controller controls ready and configured to work with Bluetooth or USB on multiple games and game system emulations
* 100 separate and easily-accessible save states per game
* Rewind feature turns all retro games into Braid or Prince Of Persia: Sands of Time and is togglable per system
* Cloud save and save state backup to mega.co.nz
* Support for the SNES Mouse / Mario Paint with easy launch
* Easy pairing scripts for bluetooth keyboards and mice
* Automatic PS3-like pairing routine for controllers (plug in PS3 controller via USB for ~5 seconds, unplug and then can connect via bluetooth until a real PS3 or different Bluetooth adapter is paired).  

Here is a list of all the officially supported systems on the PrimeStation One, running full speed:
* Atari 800
* Atari 2600
* Atari 5200
* Atari ST / Falcon
* Atari Lynx
* Nintendo Entertainment System (NES)
* Game Boy and Game Boy Color
* Super NES (SNES)
* Super NES with SNES Mouse support for Mario Paint
* Sony Playstation One (PSX / PS1)
* Sega Master System
* Sega SG-1000
* Sega Genesis / Megadrive
* Sega CD
* Sega 32x
* Commodore 64
* Amiga
* Neo Geo
* MAME (specifically for older MAME 37b5 ROMS)
* MSX
* TurboGrafx-16 (PC-Engine)
* DOS / IBM-PC / MS-DOS
* Infocom ZMachine (Zork I, II, III)
* SCUMMVM (for many DOS adventure games)
* Apple ][
* Apple Macintosh Classic (Up to OS 8)
* Sinclair ZX Spectrum
* Intellivision
* Amstrad CPC

Also included are the following Raspberry Pi native shareware / freeware games (ports):
* Doom 
* Quake
* Quake 3 Arena
* Duke Nukem 3D
* Cave Story
* Angband
* Descent 1
* Descent 2

The following are systems that are included but experimental on the PrimeStation One (under development, not full speed on some or all games, etc):
* Atari 7800 Prosystem
* Nintendo 64
* Sega Saturn
* Sega Dreamcast



#### Please Note: The PrimeStation One's main driving force is to do ALL THE THINGS!
=============

#### PrimeStation One theme for EmulationStation github repo:
https://github.com/free5ty1e/primestationone-estheme

## NOTE:
primeStationOne images / installations older than v0.951alpha can not be automatically updated to the latest by simply running the quick update script.  They must run the following commands to purge and recreate the git repository, since it has been recreated on GitHub for v0.951alpha and later (This is also the same command sequence one should use to install the PrimeStation One over top of a fresh vanilla RetroPie image.  It is all in one line so it is easy to copy / paste into a terminal window SSH session):
```
rm -rf ~/primestationone && pushd ~ && git clone https://github.com/free5ty1e/primestationone.git && popd && ~/primestationone/bin/installPrimeStationOneFiles.sh && quickResetPrimestationOne.sh && installMegaTools.sh && sudo service dphys-swapfile stop && sudo rm /var/swap && installDescent1and2.sh && upgrade2gMinPrimestationToFull.sh
```

ADDITIONALLY, with v0.951alpha comes the decoupling of the primestationone theme from the repo.  The theme will be available separately in the same share as the PrimeStationOne image (below).  The theme no longer overwrites the Simple theme, there is a Primestation theme to select in the EmulationStation menu now.  Using the above command sequence, you will end up with the Primestation One theme installed and selected.

##NOTE ABOUT USING PS3 CONTROLLERS VIA USB
It is important to note that as much automation was integrated as was possible... this includes the automatic PS3 bluetooth controller pairing procedure that fires at the moment a PS3 controller is plugged in via USB while the system is powered on.  

This makes it extremely easy to use PS3 controllers via bluetooth; just like a real PS3, to pair a new controller to the Primestation One, just plug it in via USB while the system is powered on.

If you have no compatible bluetooth adapter, your USB PS3 connection should work just fine. 

If you have a bluetooth adapter but want to use PS3 controllers over USB anyway, you will need to remove your bluetooth adapter anyway to stop the aggressive automatic PS3 bluetooth first-time pairing procedure; when plugging a controller in via USB, the Primestation tells that controller to pair with the Primestation (just like the PS3 handles controllers).  It is currently not easy to mix bluetooth and USB PS3 controller connections on the same Primestation simultaneously (you'd have to manually disable the PS3 USB connection rule).

Some additional tips for USB PS3'ing:
* Keep in mind that while a PS3 controller is connected via USB, it will draw a good 500+mA of current from your Raspberry Pi's precious power source!  If you only have a 1.5A or less, you probably don't have this much to spare - and the result will be the entire USB bus will be shut down!  
* If you have several PS3 controllers plugged in via USB, it's best to have either a beefy power supply for the Pi or a powered USB 2.0 hub to connect them through in order to avoid glitchy power supply issues.

## BASIC USAGE and DOWNLOADS
###  Download the latest primeStationOne image archive (and any other modules / tools you are interested in) from the following MEGA (mega.co.nz) share: http://goo.gl/RPKAr1

If you have managed to obtain one of these releases, extract the .7z archive so you have the .img file.  

Here are the commands to write the image file on Mac and Linux with a progress bar as well.  The v0.9998 beta release archive is used for this example, adjust accordingly if you have a different version.  You will need a minimum of a 4GB SD card to begin using the PrimeStation One.  Once (and if) you've transferred the root filesystem to USB, you can manually prepare a tiny SD card (any size above 50 MB will work) to act as a boot drive for the USB PrimeStation and free up your 4GB SD card for other uses.

####Install on Mac: (`brew install pv` if you don't have pv.  If you don't have Homebrew, too bad for you.)   Replace the device `/dev/disk2` with your SD card designation (disk1, disk2, disk3...).
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

#### First time running PrimeStation One from ready-to-go 4GB SD card image
Starting with v0.9998, the full-featured 4GB SD card image (if available) is ready to use (and also the only way to go now)!  

First, decide if you want to run the PrimeStation One from the SD card only or do you have a USB drive you'd like to dedicate to the system?  

1. Either expand SD filesystem to fill your >4GB SD card (`sudo raspi-config` -> Expand Filesystem, also feel free to Overclock your Pi here if you have heat sinks or fans) or transfer root filesystem to USB (`usbRootFilesystemSetup.sh` and follow the instructions when prompted)
2. Reboot

#### Expanding your SD filesystem to fill your SD card > 4GB
...this is the "normal" method of running a Raspberry Pi, directly and only from an SD card.  SD card space is typically slower and more expensive when compared to USB storage, and it's great to have more space for ROMs, so we recommend you follow the next section and transfer your root filesystem to a dedicated USB drive.  However, if you'd prefer to run off SD only, simply run the following command:
```
sudo raspi-config
```
...select `Expand Filesystem` from the menu, exit, and follow the prompt to reboot your Pi.  This ONLY works for SD card root filesystems.


#### Transferring your PrimeStation One SD root filesystem to a USB drive:
...is typically faster depending on the USB drive itself vs the SD card you are using, and handy since USB storage space is normally less expensive and more available than SD card storage space.  USB storage will probably also last longer, as it was designed for more write cycles.  This way, you'll only end up needing to dedicate an SD card with > `50 MB` (yes, megabytes) of storage to your PrimeStation One and you can have all the roms you can cram onto your USB flash or hard drive.

As of v0.9997, a newer, safer, and fully-automated `usbGuidRootFilesystemSetup.sh` script was created to handle transferring the root filesystem to a USB drive, set up with a GPT partition table and unique GUID to boot from.  This method will NOT cause issues with USB mount order upon startup if you, for example, wanted to use your PrimeStation One as a SAMBA fileserver in the background to serve up terabytes of USB storage... this is now possible without having to physically reconnect them in a certain order after every startup.

Then, as an added bonus, you now only need an SD card with `50 MB` capacity... so if you would like to free up your larger SD card (which you just transferred the root filesystem from) for other uses, and have a smaller SD card lying around you would like to use to boot your USB-based PrimeStation, here is what to do:

1. Shut down the PrimeStation and remove the SD card
2. Insert SD card into a Linux or Mac / BSD computer via a USB or larger SD card adapter, so you can read the "BOOT" volume (don't worry, it's FAT and should be visible without any special drivers.  Windows should probably work too since FAT doesn't have any special permissions or ownership that needs preservation).
3. Create a folder called `PiBoot` on your desktop and copy all the files and folders from the SD card's "BOOT" volume over to the `PiBoot` folder.
4. Safely eject / remove the SD card from your computer, and insert the smaller SD card you'd like to utilize to boot the Primestation
5. Format this smaller SD card to its full capacity (you will just end up with more free space on the `/boot` volume which you can use if you wish), as FAT16 or FAT32 as appropriate (if > 2GB, requires FAT32)
6. Copy all the files and folders from your `PiBoot` folder over to the root of this SD card
7. Safely eject / remove SD card from computer, insert into Pi
8. Boot Pi from your new smaller SD card!   


OLDER METHOD:
The PrimeStation One v0.951alpha introduces a new `usbRootFilesystemSetup.sh` script to handle this process almost completely for you, save for some instructed keystrokes.

Yes.  Plug in your USB drive, and type `usbRootFilesystemSetup.sh` in order to start the guided process.  In some rare cases, you may find (by typing `df -h`) that your USB drive has mounted twice, in both `/media/usb0` and `/media/usb1` for some reason.  In this case, you can type `sudo umount /dev/sda1` until it complains that `sda1` is not mounted anywhere.

This process takes about 20-30 minutes, depending on the speeds of your SD card and USB drive.  

I heavily recommend starting with a fresh PrimeStationOne SD imaged with v0.951alpha or later, and transferring to USB first thing instead of expanding the filesystem on the SD card first for any reason (via the `sudo raspi-config` menu, only works for SD cards, DON'T do this if you are going to USB).  

Part of the guided process is to expand the USB filesystem from the initial 4G to however large your USB drive is.  

Plenty of space for ROMS now!!  xD 

###### If you have trouble booting from your USB drive after a crash or other issue, your USB filesystem may need to be checked / cleaned / fixed.  To workaround the issue, wait until your Pi gives you some error message about the USB drive during startup (gotta let it sit for a good 25 seconds or so), then you can pull out the USB drive and reinsert it.  This should enable the PrimeStation One USB to continue booting.  Once you're in, get to a command prompt (`F4` to quit EmulationStation), and type the following and answer Yes (should be default for `ENTER`) to all prompts to fix:
```
sudo e2fsck -f /dev/sda1
```

#### PrimeStation One MEGA.co.nz module auto-install scripts (as of V0.960alpha):
The PrimeStation One's modules are now released through mega.co.nz's awesome cloud by running more automated scripts!

(NOTE: If any of these installation scripts ever fails on you, be sure you try running a `quickUpdatePrimestationOneFiles.sh` as this will ensure you have the very latest module version download links.)

First, type `installMegaTools.sh` to handle building and installation of the very handy MegaTools, which are required for any module installations.  Or look in Emulationstation on the first PS3 controller icon, the `Settings` page, under `Installs` to accomplish the same feat without command line.  

After this is complete, the available Primestation One Mega Modules may be chosen and installed at will from the same Emulationstation `Settings` page, under `MegaModules`.  Beware -- some of these, such as the complete SNES collection, are quite large!  (over 50 GB for this one!).  The `binsnroms` archive contains the widest spread of usefulness, and also enables many things that would otherwise require much manual intervention on your part... highly recommended.

#### Amiga emulator (uae4all) on the PrimeStation One:
Since v0.962, usage of the megaInstallBinsNRoms.sh script will also install a special WORKING version of the Amiga emulator (uae4all) from the following post on the Raspberry Pi forums:
http://www.raspberrypi.org/forums/viewtopic.php?f=78&t=80602

The important thing to remember is that dispmanx MUST be disabled for the uae4all emulator in order for this emulator to function!  You can do this from the RetroPie Setup menu (available through the Settings page in EmulationStation).

#### Netplay for RetroArch / LibRetroCore-enabled emulators
As of v0.976, a handy netplay configuration / enable / disable script is provided on the EmulationStation settings page!
Or, you can type `netplayConfigForRetroArchLibretrocoreEmulators.sh` to launch from the terminal.

From here, you can enable / disable and configure netplay functionality on libretrocore enabled emulators, a list of which is located in the repository here: [!ListOfNetplayEmus](http://raw.githubusercontent.com/free5ty1e/primestationone/master/reference/txt/listOfLibRetroCores.txt)

### Cloud Save Game and Save State Backup
As of v0.9999, the Primestation One has the capability to link to a Mega.co.nz cloud drive for save state and save game backup / restore purposes.  Never lose your precious saves again!

In the EmulationStation `Settings` page (the start-up page), scroll down to the `cloudBackup` folder and look inside for the (hopefully self-explanatory) scripts you will need:

```
mega_cloud_login.sh
mega_cloud_clear_login.sh
mega_cloud_backup_all_savestates_and_srams.sh
mega_cloud_restore_all_savestates_and_srams.sh
```


### Playing Mario Paint on SNES with the Mouse
...can be achieved, but only on a Pi2 as it requires the `*Super Nintendo - SNES9xNextPi2` emulator (4th Super Nintendo emulator listed when pressing `right` to browse from the starting point).

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

### Troubleshooting
Some of the previous versions of the PrimeStation One may or may not have inadvertently caused some ownership issues in the user file structure, and / or left unused or outdated scripts lying around where they can cause confusion.  The best way to ensure that things are really set as they should be, and that you have the absolute best starting point to move forward, you should run the following script.  Be prepared to lose your cached gamelists, custom emulationstation input adjustments and general settings:
```
quickResetPrimestationOne.sh
```


#### Building emulators from source / downloading binaries (RetroPie)
Type the follwing to get into the RetroPie setup menu, where you can choose individual or multiple emulators to install or build from binaries or source:

```
sudo ~/RetroPie-Setup/retropie_setup.sh
```

IMPORTANT: If you plan to build and use the N64 emulator (mupen64plus), you will need to change your memory split to 128MB for the GPU and 384MB for the CPU for smooth emulation, and of course will need to overclock to the "Turbo" setting (both of these things can be done from the `sudo raspi-config` menu).  With this much load on the Pi, consider at least a 2 amp power supply and some heat sinks and / or fan(s) to avoid overheating.  You may check the temperature in both *C and *F of your Pi's CPU and GPU at any time by logging in via SSH (its in the welcome message), and also by typing one of the following (all perform different types and speeds): 
```
pitemp
pitemp.sh
pytemp.py
```

## FUTURE
All plans for future enhancements are now documented as individual Primestation One issues, labeled as `Enhancements` and prefixed with `FEATURE:` 

Comments / suggestions / contributions to the code welcome!  

### CREDITS
* Chris "Prime" Paiano (Founder, Lead Developer) - Twitter: @ChrisPaiano
* "Circuit Static" (User Experience, Quality, Development & Marketing) - Twitter: @CircuitStatic

....

#### Standing on the Shoulders of Giants 
(Wouldn't have been possible, or at least nearly this easy, without the following...)
* RetroPie project (https://github.com/petrockblog/RetroPie-Setup)
* QtSixA project (http://qtsixa.sourceforge.net/)
