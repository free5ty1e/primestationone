#!/bin/bash

echo First parameter should be the Pi IP address, which you passed as $1

rsync -avzh --progress --delete BIOS pi@$1:/home/pi

rsync -avzh --progress pi@$1:/opt/retropie/configs opt/retropie/

rsync -avzh --progress pi@$1:/opt/retropie/emulators/rpix86/*.sh opt/retropie/emulators/rpix86

rsync -avzh --progress pi@$1:/home/pi/.emulationstation/*.cfg home/pi/.emulationstation

rsync -avzh --progress pi@$1:/home/pi/bin .

rsync -avzh --progress pi@1:/home/pi/.bashrc home/pi/.bashrc

rsync -avzh --progress pi@$1:/etc/emulationstation/themes etc/emulationstation

rsync -avzh --progress splashscreen.png pi@$1:/home/pi/RetroPie-Setup/supplementary/splashscreens/retropieproject2014/splashscreen.png

#rsync -avzh --progress --delete roms pi@$1:/home/pi
