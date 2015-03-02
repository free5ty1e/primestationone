#!/bin/bash

controlsMappingOverlay=$(cat ~/primestationone/controlsMappingOverlay.txt)
controlsMappingTextColor=$(cat ~/primestationone/controlsMappingTextColor.txt)

echo "PrimeStation One updating splashscreen controls text overlay with"
echo "$controlsMappingOverlay"
echo "in color $controlsMappingTextColor..."
echo "More info on the process at http://www.instructables.com/id/Add-text-to-images-with-Linux-convert-command/?ALLSTEPS"
echo "......"

convert -pointsize 32 -fill "$controlsMappingTextColor" -draw "text 12,260 \"$controlsMappingOverlay\"" ~/splashscreenversion.png ~/splashscreenwithcontrolsandversiontemp.png


listOfLibRetroCores=$(cat ~/primestationone/listOfLibRetroCores.txt)
colorOfLibRetroCores=$(cat ~/primestationone/listOfLibRetroCoresColor.txt)

echo "PrimeStation One updating splashscreen mapped emulator list text overlay with"
echo "$listOfLibRetroCores"
echo "in color $colorOfLibRetroCores..."
echo "More info on the process at http://www.instructables.com/id/Add-text-to-images-with-Linux-convert-command/?ALLSTEPS"
echo "......"

convert -pointsize 30 -fill "$colorOfLibRetroCores" -draw "text 1560,260 \"$listOfLibRetroCores\"" ~/splashscreenwithcontrolsandversiontemp.png ~/splashscreenwithcontrolsandversiontemp2.png

keysToQuitEmusList=$(cat ~/primestationone/reference/keysToQuitEmus.txt)
colorKeysToQuitEmus=$(cat ~/primestationone/reference/keysToQuitEmusColor.txt)

echo "PrimeStation One updating splashscreen non-mapped emulator quit key list text overlay with"
echo "$keysToQuitEmusList"
echo "in color $colorKeysToQuitEmus..."
echo "More info on the process at http://www.instructables.com/id/Add-text-to-images-with-Linux-convert-command/?ALLSTEPS"
echo "......"

convert -pointsize 18 -fill "$colorKeysToQuitEmus" -draw "text 760,245 \"$keysToQuitEmusList\"" ~/splashscreenwithcontrolsandversiontemp2.png ~/splashscreenwithcontrolsandversion.png


rm -v ~/splashscreenwithcontrolsandversiontem*.png

echo "Complete, if you didn't just see any errors."
