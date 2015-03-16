#!/bin/bash

primestationVersion=$(cat ~/primestationone/reference/txt/version.txt)
primestationVerColor=$(cat ~/primestationone/reference/txt/vercolor.txt)
controlsMappingOverlay=$(cat ~/primestationone/reference/txt/controlsMappingOverlay.txt)
controlsMappingTextColor=$(cat ~/primestationone/reference/txt/controlsMappingTextColor.txt)
listOfLibRetroCores=$(cat ~/primestationone/reference/txt/listOfLibRetroCores.txt)
colorOfLibRetroCores=$(cat ~/primestationone/reference/txt/listOfLibRetroCoresColor.txt)
keysToQuitEmusList=$(cat ~/primestationone/reference/txt/keysToQuitEmus.txt)
colorKeysToQuitEmus=$(cat ~/primestationone/reference/txt/keysToQuitEmusColor.txt)
echo "PrimeStation One $primestationVersion updating splashscreen version text overlay with $primestationVersion in color $primestationVerColor..."
echo "...and a $controlsMappingTextColor controlsMappingOverlay: "
echo "$controlsMappingOverlay"
echo "...and a $colorOfLibRetroCores listOfLibRetroCores: "
echo "$listOfLibRetroCores"
echo "...and a $colorKeysToQuitEmus keysToQuitEmusList: "
echo "$keysToQuitEmusList"
echo "More info on the process at http://www.instructables.com/id/Add-text-to-images-with-Linux-convert-command/?ALLSTEPS"
echo "......"
convert -font courier-bold -pointsize 44 -fill "$primestationVerColor" -draw "text 1600,45 \"$primestationVersion\"" -pointsize 32 -fill "$controlsMappingTextColor" -draw "text 12,260 \"$controlsMappingOverlay\"" -pointsize 30 -fill "$colorOfLibRetroCores" -draw "text 1560,260 \"$listOfLibRetroCores\"" -pointsize 20 -fill "$colorKeysToQuitEmus" -draw "text 810,245 \"$keysToQuitEmusList\"" ~/splashscreen.png ~/splashscreenwithcontrolsandversion.png
echo "Complete, if you didn't just see any errors."
