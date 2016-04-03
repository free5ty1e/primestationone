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


#####OLDER METHOD:
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
