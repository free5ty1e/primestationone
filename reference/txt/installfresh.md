####Installing over a fresh RetroPie image:

You'll probably first want to run `sudo raspi-config`, update the raspi-config tool itself from Advanced, and set up things like your memory split, overclock, and internationalization options.  (Probably also reboot after this.)

Then, run `sudo ~/RetroPie-Setup/retropie_setup.sh` and navigate the menu to update the RetroPie script, enable SSH connections if desired, install the appropriate PS3 driver(s) for your needs, set up your wifi connection if needed (ethernet really is recommended), and configure your system the way you'd like.  (Probably also reboot after this.)

Then, make sure you are connected to the Internet, and copy / paste the following command into your Pi via a nice handy SSH session (or type it, whatever):
```
pushd ~ && rm -rf primestationone && git clone https://github.com/free5ty1e/primestationone.git && primestationone/bin/installPrimeStationOneFiles.sh && popd && finishPrimestationInstall.sh
```

...You will end up in a the audio mixer `alsamixer`, where I recommend you crank your volume up from 40% to 100% with the `UP` arrow before pressing `ESC` to exit and save.  Then probably turn your TV volume down before starting a game.  Wow, you have plenty of volume :o


### Building emulators from source / downloading binaries (RetroPie)
Launch `RETROPIE-SETUP` from the Retropie menu in Emulationstation to get into the RetroPie setup menu, where you can choose individual or multiple emulators to install or build from binaries or source.

*IMPORTANT for the Pi1:* If you plan to build and use the N64 emulator (mupen64plus), you will need to change your memory split to 128MB for the GPU and 384MB for the CPU for smooth emulation, and of course will need to overclock to the "Turbo" setting (both of these things can be done from the `sudo raspi-config` menu).  With this much load on the Pi, consider at least a 2 amp power supply and some heat sinks and / or fan(s) to avoid overheating.  You may check the temperature in both *C and *F of your Pi's CPU and GPU at any time by logging in via SSH (its in the welcome message), and also by typing one of the following (all perform different types and speeds): 
```
pitemp
pitemp.sh
pytemp.py
```
