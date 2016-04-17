#!/bin/bash

echo primeStationOneCopyFilesToPi script - to be run from the installing computer after setting up an SSH key for passwordless SCP transfers...
echo First parameters should be Pi IP address, which you entered as $1

echo Copying files over to the Pi...

scp -r . pi@$1:/home/pi

scp ./splashscreen.png pi@$1:/home/pi/RetroPie-Setup/supplementary/splashscreens/retropieproject2014/splashscreen.png






