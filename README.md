# PrimeStation One
## A Set of Scripts and Tools For a "Ready-To-Go" RetroPie (for Raspberry Pi, model B+ recommended) with PS3 controls ready and configured to work with Bluetooth or USB on multiple games and game system emulations.

#### Please Note: The PrimeStation One's main driving force is to do ALL THE THINGS!
=============

### PS3 Controller Layout / Quick Reference: 
![SplashScreen](http://verilyshare.circuitstatic.com/splashscreen.png)
http://verilyshare.circuitstatic.com/splashscreen.png 

#### Demo / startup splash videos:
![Video](http://verilyshare.circuitstatic.com/video00.mov)
http://verilyshare.circuitstatic.com/video00.mov

![Video](http://verilyshare.circuitstatic.com/video01.mov)
http://verilyshare.circuitstatic.com/video01.mov


## NOTE:
primeStationOne images / installations older than v0.951alpha can not be automatically updated to the latest by simply running the quick update script.  They must run the following commands to purge and recreate the git repository, since it has been recreated on GitHub for v0.951alpha and later:
```
        cd ~/RetroPie-Setup
        sudo git reset --hard
        cd ~
        rm -rf primestationone
        git clone https://github.com/free5ty1e/primestationone.git
        cd primestationone
        bin/installPrimeStationOneFiles.sh
        quickUpdatePrimestationOneFiles.sh
```
ADDITIONALLY, with v0.951alpha comes the decoupling of the primestationone theme from the repo.  The theme will be available separately in the same share as the PrimeStationOne image (below).  The theme no longer overwrites the Simple theme, there is a Primestation theme to select in the EmulationStation menu now.

## BASIC USAGE
###  Download the latest primeStationOne image archive (and any other modules / tools you are interested in) from the following MEGA (mega.co.nz) share: http://goo.gl/RPKAr1

If you have managed to obtain one of these releases, extract the .7z archive so you have the .img file.  

Here are the commands to write the image file on Mac and Linux with a progress bar as well.  The v0.960 alpha release archive is used for this example, adjust accordingly if you have a different version.  You will need a minimum of a 2GB SD card to begin using the PrimeStation One (although, in that form, it won't quite yet do all the things yet.  However, it's the quickest and simplest way to get started so here we go!):

####Install on Mac: (`brew install pv` if you don't have pv.  If you don't have Homebrew, too bad for you.)   Replace the device `/dev/disk1` with your SD card desingation (disk1, disk2, disk3...).
```
        pv --size 2000000000 primeStationOne2gSdV0.960alpha.img | sudo dd bs=2m of=/dev/disk1
```
...or, I suppose you COULD do it without pv and just watch a blank cursor and guess how fast it is transferring and how far along it is and how much longer it will be, by typing:
```
        sudo dd bs=2m if=primeStationOne4gSdV0.951alpha.img of=/dev/sdb
```


####Install on Linux: (`sudo apt-get install pv` if you don't have pv)  Replace the device `/dev/sdb` with your SD card designation (sda, sdb, sdc...).
```
        pv --size 2000000000 primeStationOne2gSdV0.960alpha.img | sudo dd bs=2M of=/dev/disk1
```
...or, I suppose you COULD do it without pv and just watch a blank cursor and guess how fast it is transferring and how far along it is and how much longer it will be, by typing:
```
        sudo dd bs=2M if=primeStationOne4gSdV0.951alpha.img of=/dev/sdb
```


####Install on Windows: Follow this instruction.

Go here for Windows install instructions
http://www.raspberrypi.org/documentation/installation/installing-images/windows.md



#### First time running PrimeStation One from image
Starting with v0.970, the lightweight 2G SD card image will be as ready to go as reasonably possible in the compact 2GB starter image.  First, decide if you want to run the PrimeStation One from the SD card only or do you have a USB drive you'd like to dedicate to the system?  

1. Either expand SD filesystem to fill your >2GB SD card (`sudo raspi-config` -> Expand Filesystem) or transfer root filesystem to USB (`usbRootFilesystemSetup.sh` and follow the instructions when prompted)
2. Reboot
3. Execute `quickUpdatePrimestationOneFiles.sh` to actually initiate the install of the PrimeStation One now that we have enough space to proceed (you DID transfer to a 4+GB SD or 4+GB USB, didn't you?)
4. If you have at least another ~5GB free on your root filesystem, you may optionally auto install all PrimeStation One modules by typing `megaInstallAllModules.sh` (individual install scripts also exist for convenience, highly recommend at least installing the two smaller `megaInstallBinsNRoms.sh` and `megaInstallThemePrimeStationOne.sh` modules to enable the majority of emulators and functionality.
5. Optionally attach a wifi and / or a bluetooth dongle as both should be pretty well supported by this point
6. Attach PS3 controller via USB (can pair via bluetooth from the Emulationstation Settings screen or by typing `sudo sixpair`)
7. Reboot, behold splashscreen and videos during startup that cease as soon as Emulationstation is ready to launch

#### New alternate first-time Step 3 as of v0.975:
3: Execute `primeStationOneFirstTimeSetupAndReset.sh` and be prepared to sit back and relax (or do something else entirely) for a couple hours while everything is put in place and built and installed as best as the script currently knows how (will reinstall all latest emulators us devs currently care about, blank out the gamelists, ensure all required packages are installed, all latest PORTS, etc...)

#### Expanding your SD filesystem to fill your SD card > 2GB
...this is the "normal" method of running a Raspberry Pi, directly and only from an SD card.  SD card space is typically slower and more expensive when compared to USB storage, and it's great to have more space for ROMs, so we recommend you follow the next section and transfer your root filesystem to a dedicated USB drive.  However, if you'd prefer to run off SD only, simply run the following command:
```
sudo raspi-config
```
...select `Expand Filesystem` from the menu, exit, and follow the prompt to reboot your Pi.  This ONLY works for SD card root filesystems.


#### Transferring your PrimeStation One SD root filesystem to a USB drive:
...is typically faster depending on the USB drive itself vs the SD card you are using, and handy since USB storage space is normally less expensive and more available than SD card storage space.  USB storage will probably also last longer, as it was designed for more write cycles.  This way, you'll only end up needing to dedicate an SD card with > 16MB (yes, megabytes) of storage to your PrimeStation One and you can have all the roms you can cram onto your USB flash or hard drive.

The PrimeStation One v0.951alpha introduces a new ```usbRootFilesystemSetup.sh``` script to handle this process almost completely for you, save for some instructed keystrokes.

Yes.  Plug in your USB drive, and type ```usbRootFilesystemSetup.sh``` in order to start the guided process.  In some rare cases, you may find (by typing ```df -h```) that your USB drive has mounted twice, in both /media/usb0 and /media/usb1 for some reason.  In this case, you can type ```sudo umount /dev/sda1``` until it complains that ```sda1``` is not mounted anywhere.

This process takes about 20-30 minutes, depending on the speeds of your SD card and USB drive.  

I heavily recommend starting with a fresh PrimeStationOne SD imaged with v0.951alpha or later, and transferring to USB first thing instead of expanding the filesystem on the SD card first for any reason (via the ```sudo raspi-config``` menu, only works for SD cards, DON'T do this if you are going to USB).  

Part of the guided process is to expand the USB filesystem from the initial 4G to however large your USB drive is.  

Plenty of space for ROMS now!!  xD 

###### If you have trouble booting from your USB drive after a crash or other issue, your USB filesystem may need to be checked / cleaned / fixed.  To workaround the issue, wait until your Pi gives you some error message about the USB drive during startup (gotta let it sit for a good 25 seconds or so), then you can pull out the USB drive and reinsert it.  This should enable the PrimeStation One USB to continue booting.  Once you're in, get to a command prompt (`F4` to quit EmulationStation), and type the following and answer Yes (should be default for `ENTER`) to all prompts to fix:
```
sudo e2fsck -f /dev/sda1
```

#### PrimeStation One MEGA.co.nz module auto-install scripts (as of V0.960alpha):
The PrimeStation One's modules are now released through mega.co.nz's awesome cloud by running more automated scripts!

(NOTE: If any of these installation scripts ever fails on you, be sure you try running a `quickUpdatePrimestationOneFiles.sh` as this will ensure you have the very latest module version download links.)

First, type `installMegaTools.sh` to handle building and installation of the very handy MegaTools, which are required for any module installations.

Then, type any or all of the following (`megaInstallAllModules.sh` will go through and install them all for you if you are lazy):
```
megaInstallBinsNRoms.sh
megaInstallBinsNRomsLarge.sh
megaInstallThemePrimeStationOne.sh
```

Installation of each module may take up to 20ish minutes, depending on your connection speed and overclock settings (7z max compression is a bit intensive on the Pi).  

The goal here is, after installing all modules, you should have a theme for every emulator and at least one working thing for every emulator.  

#### Amiga emulator (uae4all) on the PrimeStation One:
Since v0.962, usage of the megaInstallBinsNRoms.sh script will also install a special WORKING version of the Amiga emulator (uae4all) from the following post on the Raspberry Pi forums:
http://www.raspberrypi.org/forums/viewtopic.php?f=78&t=80602

Installing the Amiga emulator from RetroPie (or updating RetroPie binaries) will overwrite this installation, and you will need to run the megaInstallBinsNRoms.sh script again in order to get it back (although it will be removed at some point when RetroPie's version is fixed).

The important thing to remember is that dispmanx MUST be disabled for the uae4all emulator in order for this emulator to function!  You can do this from the RetroPie Setup menu (available through the Settings page in EmulationStation).

#### Netplay for RetroArch / LibRetroCore-enabled emulators
As of v0.976, a handy netplay configuration / enable / disable script is provided on the EmulationStation settings page!
Or, you can type `netplayConfigForRetroArchLibretrocoreEmulators.sh` to launch from the terminal.

From here, you can enable / disable and configure netplay functionality on libretrocore enabled emulators (here's a list as of v0.976 / 2015.02.18):
```
NeoGeo
MSX
GameBoy
GameBoy Color
GameGear
Atari Lynx
MAME
TurboGrafx16
Nintendo
Super Nintendo
N64
Sega Master System
Sega Genesis
Sega CD
Sega 32x
Playstation 1
Atari 2600
Atari 7800
Vectrex 
3D0
```

##### IMPORTANT:
If you start in Host mode, your emulator may *freeze* until a Client connects.  If you want to play single-player again, you should run the script again and disable netplay!


#### Building emulators from source / downloading binaries (RetroPie)
Type the follwing to get into the RetroPie setup menu, where you can choose individual or multiple emulators to install or build from binaries or source:

```
sudo ~/RetroPie-Setup/retropie_setup.sh
```

SOON: List of emulators PrimeStation One recommends / works best for most situations.  For now, just recommend build ALL emulators from source and give it a good 30ish hours to do so, then build each experimental item so you can support all the things (another 3-4 hours, mostly on that MSX emu build)...

IMPORTANT: If you plan to build and use the N64 emulator (mupen64plus), you will need to change your memory split to 128MB for the GPU and 384MB for the CPU for smooth emulation, and of course will need to overclock to the "Turbo" setting (both of these things can be done from the `sudo raspi-config` menu).  With this much load on the Pi, consider at least a 2 amp power supply and some heat sinks and / or fan(s) to avoid overheating.  You may check the temperature in both *C and *F of your Pi's CPU and GPU at any time by logging in via SSH (its in the welcome message), and also by typing one of the following (all perform different types and speeds): 
```
pitemp
pitemp.sh
pytemp.py
```

#### BELOW IS NOT RECOMMENDED / OUTDATED INFO!!  CONTINUE IF YOU WANT TO START FROM A FRESH RETROPIE IMAGE INSTEAD:
Install RetroPie (https://github.com/petrockblog/RetroPie-Setup) by writing from an SD card image downloaded from their site (http://blog.petrockblock.com/retropie/retropie-downloads/).  

Once you can type 'emulationstation' from the command line and get into the basic EmulationStation interface and see one or two entries, you can continue with the PrimeStation One overlay scripts.

Clone the github repo for the primeStationOne to your Pi home folder and start the setup. (git pull is included in case you want to copy / paste the entire block below and paste into an SSH terminal window, to update if you've already cloned)
```
        cd ~
        git clone https://github.com/free5ty1e/primestationone.git
        cd primestationone
        git pull
        bin/primeStationOneSetup
```
    
Once this script completes, you should end up in the `RetroPie-Setup/retropie_setup.sh` menu, and you can just exit at this point if you'd like and restart (as your Pi may or may not have updated its firmware in the process as part of the self updating stuffs).  Note:  You can now type `restart` to restart the thing or `off` to turn off the thing.
    
At this point, there is a menu entry in the EmulationStation Settings menu page (script page) to `updatePrimeStationOneFull.sh`, which you can also type in a command terminal.  It will perform a git pull to retrieve the latest verison of the setup script and supporting files, and run the `bin/primeStationOneSetup` again to ensure the latest things are thinged for your maximum thingness.
    
There is also a quick update, which takes care of only git repo updates for primestationone and RetroPie-Setup, installs primestationone files to correct locations, installs primestationone cronjobs and configures mplayer.  This all happens far faster than the full setup command.  Also: it happens every reboot via a cronjob.  Neat!  Type `quickUpdatePrimestationOneFiles` to execute the quick update (it is also in the Settings page in Emulationstation for convenience)
    
The `~/splashscreen.png` file can also be shown by typing `splashscreenQuickReference.sh`, or selecting this script from the Settings page in Emulationstation.  This also shows the layout of the PS3 controller for the auxiliary and management functions of RetroArch for most emulators (those with libretocores, of course).
    
So far mainly tested with the RetroPie image v2.3 downloaded from their site and written to SD card using a dd command.  Not sure if the very latest RetroPie built from sources will work correctly with these files, but we plan to test it soon!


## FUTURE
* Add the `opt/vc/src/hello_pi/*` demos to the Settings / Tools menu, or even a new Demos menu as these are neat to show off and why not?
* Quick reference image / controller layout / emulator notes for special emulators such as FastDosBox and RPix86 and the C64 emulator that shows via launchs script for X seconds before / while the actual emulator is loading up, so the user knows what might be useful to try on a controller from a couch...
* Menu system to handle running services, both for the current session and for all future sessions (services enabled / disabled upon startup).  The PrimeStation One can do a lot, and sometimes its nice to turn some unused features off!
* Add START + SELECT to request a soft reboot of the Pi for panic / crash situations.  This might just end up pressing CTRL-ALT-DEL if we continue to find this actually does work like we think it does...

Comments / suggestions / contributions to the code welcome!  

Credits: 
* Chris "Prime" Paiano (Founder, Lead Developer) - Twitter: @ChrisPaiano
* "Circuit Static" (User Experience, Quality, Development & Marketing) - Twitter: @CircuitStatic

Standing on the Shoulders of Giants:
* RetroPie project (https://github.com/petrockblog/RetroPie-Setup)
* XRDP project (https://github.com/kx499/xrdp)
* QtSixA project (http://qtsixa.sourceforge.net/)
