## PrimeStation One FAQ: 
* The PrimeStation One performs basic updates every time EmulationStation starts up, if an Internet connection is available.
* There are many useful scripts under the first "emulator" marked with the PlayStation controller:
* To set up your Wifi connection: `WIFI_NETWORKS` 
* To force a more detailed update,  under `SYSTEM`, `UPDATE_PRIMESTATION_ONE_FILES_QUICK` 

##### Q: Why are there so many emulators?  Why do some have icons and some have text labels?
* A: Each system *(such as Super Nintendo / SNES)* has a recommended emulator that tends to work the best on most games.  You may find that some games *(such as Final Fantasy 3)* have inaccurate sound on the recommended emulator, so you can try it out on the other SNES emulators *(FF3 plays best with the *Snes9xNext-Pi2 emulator, for example).*

##### Q: How do I pair my *Genuine Sony Playstation 3 Controller* (sixaxis or dualshock3) to the PrimeStation wirelessly?  I have a compatible Bluetooth USB adapter *(any generic CSR 4.0 based adapter from Amazon Prime).*
* A: Simply connect it via USB to a powered PrimeStation, press the center PS button, wait for **~5 seconds** or so, then remove the cable.  
* If your controller doesn't pair within 5-10 seconds, try connecting USB again while the lights are flashing, then wait ~5 seconds, and remove USB again.  It should be paired at this point, until you connect USB to a real PS3 or a different PrimeStation that tells it to connect elsewhere (then you must repeat this process).
* If you need to force the controller to shut down, **you need to hold the center PS button for a good solid 12 - 15 seconds.**  Yeah.  Sony knows you're using the controller with non-Sony hardware and makes you work for it!
* Also, you should know thatcontrollers do NOT time out when connected wirelessly; **they will stay on until dead.**

##### Q: Help, my PrimeStation crashed or is not responding!
* A: OK, that's not a question.

##### Q: ....what can I do if the PrimeStation crashes or stops responding?
* A: That's better.  If you have the PrimeStation One Control Android app installed (scan the QR code or search for `primestation` on the Play Store), you can force a graceful reset, shutdown, and several other handy functions.  
* ...If none of these controls work, you might actually have to physically remove and replace power.  The PrimeStation should recover quite handily from even the nastiest crashes after a physical shutdown / restart cycle or two...

##### Q: How do I shut down the PrimeStation One?
* A: ....why would you want to do that?  It would only cost $25-ish dollars per year at absolute maximum (emulating DreamCast or PlayStation1 24/7 with two USB controllers and bluetooth and wifi) to leave the Pi 2 on, probably typically less than half that.
* However, if you must know, there is an `OFF` command in the EmulationStation's settings menu (press `START` on the PS3 controller, or `SPACE` on your bluetooth or USB keyboard)...
* ...after which completes (the screen will go blank and the LED on the PrimeStation will stop flashing), you will have to actually disconnect power somehow from the PrimeStation.  I recommend plugging the wall outlet through a handy switch passthrough unit (sold at home improvement stores everywhere) so you have an actual switch to disconnect power.  

##### Q: How do I pair a bluetooth keyboard or mouse to the PrimeStation? 
* A: You will need a USB keyboard in order to pair a bluetooth keyboard, although you should not need one for the mouse.  
* There is a script in EmulationStation's first "emulator," which shows up as the first of two PlayStation controller icons.  
* Choose the `BLUETOOTH` folder in this list.
* Power up your bluetooth keyboard and put it in pairable / connect mode
* Choose the script `PAIR_FIRST_DISCOVERABLE_KEYBOARD` to initiate pairing.  Watch the screen for a prompt, where you will need to enter a code on the USB keyboard (like `1234` followed by pressing `<ENTER>`) and then enter the same code on the bluetooth keyboard.

[![QR Code For Play Store](https://raw.githubusercontent.com/free5ty1e/primestationone-control-android/master/app/src/main/res/drawable-nodpi/qrcode.png)](https://play.google.com/store/apps/details?id=com.chrisprime.primestationonecontrol)
