##Troubleshooting

###Hotkeys always enabled or hotkey enable button not working
See the following post for a solid way to fix these issues manually for whatever controller you may be using:
https://retropie.org.uk/forum/topic/17314/hotkey-button-always-pressed/16

```
FIX

RetroPie Configuration > RetroArch
Settings > Input
Input User 1 Binds > User 1 Device Index -- Verify this is set to the target controller
Input Hotkey Binds > Enable hotkeys -- Set this to the target hotkey button (override Auto, even if the same button)
Configurations > Save Current Configuration
```


Some of the previous versions of the PrimeStation One may or may not have inadvertently caused some ownership issues in the user file structure, and / or left unused or outdated scripts lying around where they can cause confusion.  The best way to ensure that things are really set as they should be, and that you have the absolute best starting point to move forward, you should run the following script.  Be prepared to lose your cached gamelists, custom emulationstation input adjustments and general settings:
```
quickResetPrimestationOne.sh
```

###PS3 controller connection troubleshooting

Sometimes it might take a couple tries of connecting the controller via USB for ~10 seconds to the Primestation, then disconnect and press PS3 button to attempt connection before (especially generic) controllers might start actually trying to pair to the Primestation.  Even once connected, they may not respond without reconnecting a couple more times and possibly restarting the Primestation.  This only seems to occur when connecting many different types of controllers, as I did during testing...

###NOTE ABOUT USING PS3 CONTROLLERS VIA USB
It is important to note that as much automation was integrated as was possible... this includes the automatic PS3 bluetooth controller pairing procedure that fires at the moment a PS3 controller is plugged in via USB while the system is powered on.  

This makes it extremely easy to use PS3 controllers via bluetooth; just like a real PS3, to pair a new controller to the Primestation One, just plug it in via USB while the system is powered on.

If you have no compatible bluetooth adapter, your USB PS3 connection should work just fine. 

If you have a bluetooth adapter but want to use PS3 controllers over USB anyway, you will need to remove your bluetooth adapter anyway to stop the aggressive automatic PS3 bluetooth first-time pairing procedure; when plugging a controller in via USB, the Primestation tells that controller to pair with the Primestation (just like the PS3 handles controllers).  It is currently not easy to mix bluetooth and USB PS3 controller connections on the same Primestation simultaneously (you'd have to manually disable the PS3 USB connection rule).

##### Some additional tips for USB PS3'ing:
* Keep in mind that while a PS3 controller is connected via USB, it will draw a good 500+mA of current from your Raspberry Pi's precious power source!  If you only have a 1.5A or less, you probably don't have this much to spare - and the result will be the entire USB bus will be shut down!  
* If you have several PS3 controllers plugged in via USB, it's best to have either a beefy power supply for the Pi or a powered USB 2.0 hub to connect them through in order to avoid glitchy power supply issues.

######NOTE:
primeStationOne images / installations older than v0.951alpha can not be automatically updated to the latest by simply running the quick update script.  They must run the following commands to purge and recreate the git repository, since it has been recreated on GitHub for v0.951alpha and later (This is also the same command sequence one should use to install the PrimeStation One over top of a fresh vanilla RetroPie image.  It is all in one line so it is easy to copy / paste into a terminal window SSH session):
```
rm -rf ~/primestationone && pushd ~ && git clone https://github.com/free5ty1e/primestationone.git && popd && ~/primestationone/bin/installPrimeStationOneFiles.sh && quickResetPrimestationOne.sh && installMegaTools.sh && sudo service dphys-swapfile stop && sudo rm /var/swap && installDescent1and2.sh && upgrade2gMinPrimestationToFull.sh
```

ADDITIONALLY, with v0.951alpha comes the decoupling of the primestationone theme from the repo.  The theme will be available separately in the same share as the PrimeStationOne image (below).  The theme no longer overwrites the Simple theme, there is a Primestation theme to select in the EmulationStation menu now.  Using the above command sequence, you will end up with the Primestation One theme installed and selected.


#### If you have trouble booting from your USB drive after a crash or other issue, your USB filesystem may need to be checked / cleaned / fixed.  To workaround the issue, wait until your Pi gives you some error message about the USB drive during startup (gotta let it sit for a good 25 seconds or so), then you can pull out the USB drive and reinsert it.  This should enable the PrimeStation One USB to continue booting.  Once you're in, get to a command prompt (`F4` to quit EmulationStation), and type the following and answer Yes (should be default for `ENTER`) to all prompts to fix:
```
sudo e2fsck -f /dev/sda1
```

#### Amiga emulator (uae4all) on the PrimeStation One:
Since v0.962, usage of the megaInstallBinsNRoms.sh script will also install a special WORKING version of the Amiga emulator (uae4all) from the following post on the Raspberry Pi forums:
http://www.raspberrypi.org/forums/viewtopic.php?f=78&t=80602

The important thing to remember is that dispmanx MUST be disabled for the uae4all emulator in order for this emulator to function!  You can do this from the RetroPie Setup menu (available through the Settings page in EmulationStation).
