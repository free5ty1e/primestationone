#!/bin/bash

primestationVersion=$(cat ~/primestationone/reference/txt/version.txt)
cat ~/splashscreen.ansi
cat ~/primestationfancytextimage.ansi
cat ~/beavis_butthead.ansi
echo "PrimeStation One $primestationVersion Go!"
cowsay -f beavis.zen "Heh heh... yeah... PrimeStation One $primestationVersion Go!"

showCpuSpeed.sh
