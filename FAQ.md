## PrimeStation One FAQ:

##### Q: Why are there so many emulators?  Why do some have icons and some have text labels?
* A: Each system (such as Super Nintendo / SNES) has a recommended emulator that tends to work the best on most games.  You may find that some games, such as Final Fantasy 3, have inaccurate sound on the recommended emulator, so you can try it out on the other SNES emulators (FF3 plays best with the *Snes9xNext-Pi2 emulator, for example)

##### Q: How do I pair my Genuine Sony Playstation 3 Controller (sixaxis or dualshock3) to the PrimeStation wirelessly?  I have a compatible Bluetooth USB adapter (any generic CSR 4.0 based adapter from Amazon Prime).
* A: Simply connect it via your standard USB Mini cable to a powered PrimeStation, press the center PS button, wait for ~5 seconds or so, then remove the cable.  If your controller doesn't pair within 5-10 seconds, try connecting USB again while the lights are flashing, then wait ~5 seconds, and remove USB again.  It should be paired at this point, until you connect USB to a real PS3 or a different PrimeStation that tells it to connect elsewhere (then you must repeat this process).
* If you need to force the controller to shut down, you need to hold the center PS button for a good solid 12 - 15 seconds.  Yeah.  Sony knows you're using the controller with non-Sony hardware and makes you work for it!
* Also, you should know that the controller does NOT time out when connected wirelessly.  It is recommended to force shut down the controllers when you're done with them, or you can keep one paired at all times and connected via USB.  Or two.  

##### Q: Help, my PrimeStation crashed or is not responding!
* A: OK, that's not a question.

##### Q: ....what can I do if the PrimeStation crashes or stops responding?
* A: That's better.  If you have the PrimeStation One Convenience / Control App for Android installed (scan the below QR code or search for "primestation" on the Play Store), you can force a graceful reset, shutdown, or even kill all emulators and restart the EmulationStation menu system from your phone.  
* ...If none of these controls work, you might actually have to physically remove and replace power.  The PrimeStation should recover quite handily from even the nastiest crashes after a physical shutdown / restart cycle or two...

[![QR Code For Play Store](https://raw.githubusercontent.com/free5ty1e/primestationone-control-android/master/app/src/main/res/drawable-nodpi/qrcode.png)](https://play.google.com/store/apps/details?id=com.chrisprime.primestationonecontrol)

##### Q: How do I shut down the PrimeStation One?
* A: ....why would you want to do that?  It would cost $25-ish dollars per year at maximum processing power (emulating DreamCast or PlayStation1 24/7) to run the Raspberry Pi 2 at all times and just leave it on.  Much more convenient that way.
* However, if you must know, there is an "OFF" command in the EmulationStation's settings menu (press START on the PS3 controller, or SPACE on your bluetooth or USB keyboard)...
* ...after which completes (the screen will go blank and the LED on the PrimeStation will stop flashing), you will have to actually disconnect power somehow from the PrimeStation.  I recommend plugging the wall outlet through a handy switch passthrough unit (sold at home improvement stores everywhere) so you have an actual switch to disconnect power.  
