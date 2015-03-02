#!/bin/bash
listOfLibRetroCores=$(cat ~/primestationone/reference/txt/listOfLibRetroCores.txt)
echo "Netplay $listOfLibRetroCores\n"

cowsay -f vader "Netplay should work for RetroArch / LibRetroCore emulators! $listOfLibRetroCores"
sudo ~/RetroPie-Setup/retropie_packages.sh retronetplay
