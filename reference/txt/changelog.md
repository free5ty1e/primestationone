#####v1.00 RC1 - 2016.05.06: Pi2and3 image released 
* Fixed issues with broken networking and PS3 universal bluetooth connectivities upon startup
* Genuine Sony PS3 controllers as well as newer GAsia and ShanWan controllers all now just work with this setup
* Default keyboard locale set to US, enabled `CTRL+ALT+BACKSPACE` to kill the x server.
* Should be ready to rock!

#####v1.00 beta6 - 2016.04.20: Err... broke networking startup somehow, regressing....
* Generic ShanWan && GAsia as well as genuine Sony PS3 controllers are now *actually* supported!  Confirmed working >2 players, although I have experienced a crash in Emulationstation upon adding and fiddling with a 4th controller via USB...
* Cranked up the default audio volume in alsamixer from 40% to 100%, baby!

#####v1.00 beta5 - 2016.04.19:
* Generic ShanWan PS3 controller support for Jessie (still no Gasia yet without breaking other things) - actually was broken in the released image :o
* FFMPEG / RetroArch movie recording capabilities are back - maybe?  This might have broken SEVERAL things in the image in hindsight...
* Dreamcast fixed, PS3 controller mapped
* N64 non-libretrocore PS3 controller mapped

#####v1.00 beta4 2016.04.17: 
* Based on RetroPie release 3.7.0
* Pi2/Pi3 combo image
* Auto-expand filesystem on first boot
* Emulator fixes

#####New features v1.00 beta2 2016.04.03: 
* Now based on / supports the current RetroPie release 3.6.0 (we were using 3.0.0beta2)
* Pi3 support!
* May have lost some features in the upgrade madness - these will be addressed in short order!

#####New features v1.0000beta 2016.04.01: (Pi1, Pi2 images released 2016.04.01)
Release tweet:
https://twitter.com/ChrisPrimeish/status/716110179507437568

* Most generic "ShanWan" as well as "Gasia" PS3 controllers are now supported via Bluetooth, and of course coexist with genuine Sony controllers.  Most will even rumble and show the LED animation during connection.  All the controllers pictured here can now be utilized with the Primestation: 
![SupportedGenericControllers](http://i.imgur.com/51iynW9.png)
* Experimental FFMPEG-based RetroArch emulator recording is now possible; an experimental NESTOPIA menu entry has been added to emulate and record MPG videos of you playing games, although you will probably have to disable rewind in order to play the game at a reasonable framerate while this is occurring.  The video produced looks something like this, so far no audio configured:
https://mega.nz/#!PIdHBLhC!WkaSX4_9otzCO74-7Qz1xQEBJetxHiWDKJ_Y2h09rXY

#####New features v1.0000alpha 2016.03.26: (Pi1, Pi2 images released 2016.03.28, and Pi3 support is under development...)
Release tweet:
https://twitter.com/ChrisPrimeish/status/716110179507437568

* Later model / 2015+ Generic "ShanWan" PS3 controllers now supported via Bluetooth
* Swapped SELECT and PS3 buttons; now hold the PS3 button to enable the other hotkeys instead of SELECT.  This enables SELECT as a usable button in games again, and enables many nice things (like screenshotting without having to emulator-pause to avoid advancing the game with SELECT, as in FF2)
