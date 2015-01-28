#!/bin/bash

primestationVersion=$(cat ~/primestationone/version.txt)
echo "PrimeStation One $primestationVersion updating splashscreen version text overlay..."
echo "More info on the process at http://www.instructables.com/id/Add-text-to-images-with-Linux-convert-command/?ALLSTEPS"
sudo apt-get install -y imagemagick
convert -pointsize 20 -fill yellow -draw 'text 270,460 "$primestationVersion" ' ~/primestationone/splashscreen.png ~/primestationone/splashscreenversion.png
