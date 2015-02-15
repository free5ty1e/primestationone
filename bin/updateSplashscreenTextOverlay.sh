#!/bin/bash

controlsMappingOverlay=$(cat ~/primestationone/controlsMappingOverlay.txt)
controlsMappingTextColor=$(cat ~/primestationone/controlsMappingTextColor.txt)

echo "PrimeStation One $controlsMappingOverlay updating splashscreen controls text overlay with $controlsMappingOverlay in color $controlsMappingTextColor..."
echo "More info on the process at http://www.instructables.com/id/Add-text-to-images-with-Linux-convert-command/?ALLSTEPS"
echo "......"

convert -pointsize 18 -fill "$controlsMappingTextColor" -draw "text 0,45 \"$controlsMappingOverlay\"" ~/splashscreenversion.png ~/splashscreenwithcontrolsandversion.png


echo "Complete, if you didn't just see any errors."
