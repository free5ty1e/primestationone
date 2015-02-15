#!/bin/bash


downloadLatestPrimestationOneSplashscreen.sh

primestationVersion=$(cat ~/primestationone/version.txt)
primestationVerColor=$(cat ~/primestationone/vercolor.txt)

echo "PrimeStation One $primestationVersion updating splashscreen version text overlay with $primestationVersion in color $primestationVerColor..."
echo "More info on the process at http://www.instructables.com/id/Add-text-to-images-with-Linux-convert-command/?ALLSTEPS"
echo "......"

convert -pointsize 44 -fill "$primestationVerColor" -draw "text 1660,45 \"$primestationVersion\"" ~/splashscreen.png ~/splashscreenversion.png

updateSplashscreenTextOverlay.sh


echo "Complete, if you didn't just see any errors."
