#!/bin/bash

primestationVersion=$(cat ~/primestationone/version.txt)
echo "PrimeStation One $primestationVersion updating splashscreen version text overlay..."
echo "More info on the process at http://www.instructables.com/id/Add-text-to-images-with-Linux-convert-command/?ALLSTEPS"
echo "......"
convert -pointsize 44 -fill blue -draw "text 1675,45 \"$primestationVersion\"" ~/primestationone/splashscreen.png ~/splashscreenversion.png
echo "Complete, if you didn't just see any errors."
