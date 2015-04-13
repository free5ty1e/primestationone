# PrimeStation One
## A Set of Scripts and Tools For a "Ready-To-Go" RetroPie (for Raspberry Pi, model B+ recommended) with PS3 controls ready and configured to work with Bluetooth or USB on multiple games and game system emulations.

#### Please Note: The PrimeStation One's main driving force is to do ALL THE THINGS!
=============

### A Recent PS3 Controller Layout / Quick Reference: 
![SplashScreen](http://i.imgur.com/vfZnOiO.png)
http://i.imgur.com/vfZnOiO.png

#### PrimeStation One theme for EmulationStation github repo:
https://github.com/free5ty1e/primestationone-estheme

## NOTE:
primeStationOne images / installations older than v0.951alpha can not be automatically updated to the latest by simply running the quick update script.  They must run the following commands to purge and recreate the git repository, since it has been recreated on GitHub for v0.951alpha and later (This is also the same command sequence one should use to install the PrimeStation One over top of a fresh vanilla RetroPie image.  It is all in one line so it is easy to copy / paste into a terminal window SSH session):
```
rm -rf ~/primestationone && pushd ~ && git clone https://github.com/free5ty1e/primestationone.git && popd && ~/primestationone/bin/installPrimeStationOneFiles.sh && quickResetPrimestationOne.sh && installMegaTools.sh && sudo service dphys-swapfile stop && sudo rm /var/swap && installDescent1and2.sh && upgrade2gMinPrimestationToFull.sh
```

ADDITIONALLY, with v0.951alpha comes the decoupling of the primestationone theme from the repo.  The theme will be available separately in the same share as the PrimeStationOne image (below).  The theme no longer overwrites the Simple theme, there is a Primestation theme to select in the EmulationStation menu now.  Using the above command sequence, you will end up with the Primestation One theme installed and selected.

## BASIC USAGE and DOWNLOADS
###  Download the latest primeStationOne image archive (and any other modules / tools you are interested in) from the following MEGA (mega.co.nz) share: http://goo.gl/RPKAr1

If you have managed to obtain one of these releases, extract the .7z archive so you have the .img file.  

Here are the commands to write the image file on Mac and Linux with a progress bar as well.  The v0.9997 beta release archive is used for this example, adjust accordingly if you have a different version.  You will need a minimum of a 2.1GB SD card to begin using the PrimeStation One (although, in that form, it won't quite yet do all the things yet.  However, it's the quickest and simplest way to get started so here we go!)

NOTE that a standard 2GB SD card will fall just short of the minimum space requirements, so the most reasonable minimum SD card size you will probably be able to find is a 4GB card... so use at least a 4GB SD card...

####Install on Mac: (`brew install pv` if you don't have pv.  If you don't have Homebrew, too bad for you.)   Replace the device `/dev/disk2` with your SD card desingation (disk1, disk2, disk3...).
```
        pv --size 2095055360 primeStationOne2.1gSdV0.9997betaBasedOnRetroPie3.0.0beta2RPi2.img | sudo dd bs=2m of=/dev/disk2
```
...or, I suppose you COULD do it without pv and just watch a blank cursor and guess how fast it is transferring and how far along it is and how much longer it will be, by typing:
```
        sudo dd bs=2m if=primeStationOne2.1gSdV0.9997betaBasedOnRetroPie3.0.0beta2RPi2.img of=/dev/disk2
```


####Install on Linux: (`sudo apt-get install pv` if you don't have pv)  Replace the device `/dev/sdb` with your SD card designation (sda, sdb, sdc...).
```
        pv --size 2095055360 primeStationOne2.1gSdV0.9997betaBasedOnRetroPie3.0.0beta2RPi2.img | sudo dd bs=2M of=/dev/sdb
```
...or, I suppose you COULD do it without pv and just watch a blank cursor and guess how fast it is transferring and how far along it is and how much longer it will be, by typing:
```
        sudo dd bs=2M if=primeStationOne2.1gSdV0.9997betaBasedOnRetroPie3.0.0beta2RPi2.img of=/dev/sdb
```


####Install on Windows: Follow this instruction.

Go here for Windows install instructions
http://www.raspberrypi.org/documentation/installation/installing-images/windows.md

#### First time running PrimeStation One from ready-to-go 4GB SD card image
Starting with v0.995, the full-featured 4GB SD card image (if available) is ready to use!  Just follow steps 1 and 2 in the below "First time running PrimeStation One from lightweight 2GB SD card image" and you will be good to go!  Feel free to follow step 4 for additional roms if you have the space...

#### First time running PrimeStation One from lightweight 2GB SD card image
Starting with v0.995, the lightweight 2GB SD card image will be as ready to go as reasonably possible in the compact 2GB starter image, but some emulators / ports / features are not yet compiled or installed.  First, decide if you want to run the PrimeStation One from the SD card only or do you have a USB drive you'd like to dedicate to the system?  

1. Either expand SD filesystem to fill your >2GB SD card (`sudo raspi-config` -> Expand Filesystem) or transfer root filesystem to USB (`usbRootFilesystemSetup.sh` and follow the instructions when prompted)
2. Reboot
3. Execute `upgrade2gMinPrimestationToFull.sh` to actually initiate the install of all PrimeStation One components now that we have enough space to proceed (you DID transfer to a 4+GB SD or 4+GB USB, didn't you?).  You may also accomplish this step from within Emulationstation if you'd like: navigate to the first PS3 controller icon / left-facing 8-bit Professor page, look under `System` and choose the `upgrade_primestation_minimal_to_full.sh` script.

#### Expanding your SD filesystem to fill your SD card > 2GB
...this is the "normal" method of running a Raspberry Pi, directly and only from an SD card.  SD card space is typically slower and more expensive when compared to USB storage, and it's great to have more space for ROMs, so we recommend you follow the next section and transfer your root filesystem to a dedicated USB drive.  However, if you'd prefer to run off SD only, simply run the following command:
```
sudo raspi-config
```
...select `Expand Filesystem` from the menu, exit, and follow the prompt to reboot your Pi.  This ONLY works for SD card root filesystems.


#### Transferring your PrimeStation One SD root filesystem to a USB drive:
...is typically faster depending on the USB drive itself vs the SD card you are using, and handy since USB storage space is normally less expensive and more available than SD card storage space.  USB storage will probably also last longer, as it was designed for more write cycles.  This way, you'll only end up needing to dedicate an SD card with > 16MB (yes, megabytes) of storage to your PrimeStation One and you can have all the roms you can cram onto your USB flash or hard drive.

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
* Menu system to handle running services, both for the current session and for all future sessions (services enabled / disabled upon startup).  The PrimeStation One can do a lot, and sometimes its nice to turn some unused features off!
* Add START + SELECT to request a soft reboot of the Pi for panic / crash situations.  This might just end up pressing CTRL-ALT-DEL if we continue to find this actually does work like we think it does...
* Add new Pi port `https://github.com/adventuregamestudio/ags` Adventure Game Studio
* Add Descent 1 & Descent 2 to Ports
* Add Frets On Fire X (FoFiX - my old project) to Ports
* Add Starcraft to Ports (may be armv7 / pi 2 only)
* Add Random to emus: 1) Choose evenly weighted random system, then random game in that system, mapped emus only; or 2) All emus, mapped or not, included

Comments / suggestions / contributions to the code welcome!  

Credits: 
* Chris "Prime" Paiano (Founder, Lead Developer) - Twitter: @ChrisPaiano
* "Circuit Static" (User Experience, Quality, Development & Marketing) - Twitter: @CircuitStatic

....

Standing on the Shoulders of Giants:
* RetroPie project (https://github.com/petrockblog/RetroPie-Setup)
* XRDP project (https://github.com/kx499/xrdp)
* QtSixA project (http://qtsixa.sourceforge.net/)
