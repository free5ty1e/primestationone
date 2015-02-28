#!/bin/bash

controlsMappingOverlay=$(cat ~/primestationone/controlsMappingOverlay.txt)
controlsMappingTextColor=$(cat ~/primestationone/controlsMappingTextColor.txt)

echo "PrimeStation One updating splashscreen controls text overlay with\n$controlsMappingOverlay\nin color $controlsMappingTextColor..."
echo "More info on the process at http://www.instructables.com/id/Add-text-to-images-with-Linux-convert-command/?ALLSTEPS"
echo "......"

convert -pointsize 32 -fill "$controlsMappingTextColor" -draw "text 12,260 \"$controlsMappingOverlay\"" ~/splashscreenversion.png ~/splashscreenwithcontrolsandversiontemp.png


listOfLibRetroCores=$(cat ~/primestationone/listOfLibRetroCores.txt)
colorOfLibRetroCores=$(cat ~/primestationone/listOfLibRetroCoresColor.txt)

echo "PrimeStation One updating splashscreen mapped emulator list text overlay with\n$listOfLibRetroCores\nin color $colorOfLibRetroCores..."
echo "More info on the process at http://www.instructables.com/id/Add-text-to-images-with-Linux-convert-command/?ALLSTEPS"
echo "......"

convert -pointsize 32 -fill "$colorOfLibRetroCores" -draw "text 1650,260 \"$listOfLibRetroCores\"" ~/splashscreenwithcontrolsandversiontemp.png ~/splashscreenwithcontrolsandversion.png

rm -v ~/splashscreenwithcontrolsandversiontemp.png

echo "Complete, if you didn't just see any errors."
