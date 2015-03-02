#!/bin/bash

primestationVersion=$(cat ~/primestationone/reference/txt/version.txt)
echo "PrimeStation One $primestationVersion Go!"
cowsay -f beavis.zen "Heh heh... yeah... PrimeStation One $primestationVersion Go!"

showCpuSpeed.sh
