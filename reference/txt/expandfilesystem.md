## Manually expanding your filesystem / first run (obsolete as of v1.00beta4ish)

### First time running PrimeStation One from ready-to-go 8GB SD card image
Starting with v1.0000alpha, the full-featured 8GB SD card image (if available) is ready to use (and also the only way to go now)!  

First, decide if you want to run the PrimeStation One from the SD card only or do you have a USB drive you'd like to dedicate to the system?  

1. Either expand SD filesystem to fill your SD card (`sudo raspi-config` -> Expand Filesystem, also feel free to Overclock your Pi here if you have heat sinks or fans) or transfer root filesystem to USB (`usbRootFilesystemSetup.sh` and follow the instructions when prompted)
2. Reboot

#### Expanding your SD filesystem to fill your SD card
...this is the "normal" method of running a Raspberry Pi, directly and only from an SD card.  SD card space is typically slower and more expensive when compared to USB storage, and it's great to have more space for ROMs, so we recommend you follow the next section and transfer your root filesystem to a dedicated USB drive.  However, if you'd prefer to run off SD only, simply run the following command:
```
sudo raspi-config
```
...select `Expand Filesystem` from the menu, exit, and follow the prompt to reboot your Pi.  This ONLY works for SD card root filesystems.

