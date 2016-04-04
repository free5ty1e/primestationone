####Installing over a fresh RetroPie image:
```
rm -rf ~/primestationone && pushd ~ && git clone https://github.com/free5ty1e/primestationone.git && popd && ~/primestationone/bin/installPrimeStationOneFiles.sh && finishPrimestationInstall.sh
```

...you will end up on the RetroPie PS3 driver installation menu, choose your driver here.  The normal driver works great with Sony controllers.  My fork of qtsixad does not work on Jessie yet, so I am experimenting with this.

#####Installing on a fresh RetroPie image (Pi3):
Perform the above command, and then:
```
finishPrimestationInstallPi3.sh
```


### Building emulators from source / downloading binaries (RetroPie)
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
