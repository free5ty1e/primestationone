#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
download_install_mega_module_on_the_fly binsnroms ~ 222527141 'https://mega.co.nz/#!wxxjTJ5D!sCr2klU62gB-BnH7uZDdWKW9RU7QP-uIDz_mL79hdxk' 0 0
reset_permissions_bios_and_roms

cd ~/archive
rm -rf uae4all
p7zip -d uae4all.7z
mkdir ~/RetroPie/emulators
cp -rv uae4all ~/RetroPie/emulators/

quickCreateFoldersAndLinksAndRemoveOldFiles.sh
