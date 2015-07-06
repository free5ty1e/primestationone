#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
download_install_mega_module_on_the_fly binsnroms ~ 192728081 'https://mega.co.nz/#!gsJBUKpS!Z6MODOy7uMxMQsBMibqUuIjGVzzwiUnDK0ovN6R8DFk' 0 0
reset_permissions_bios_and_roms

cd ~/archive
rm -rf uae4all
p7zip -d uae4all.7z
mkdir ~/RetroPie/emulators
cp -rv uae4all ~/RetroPie/emulators/

quickCreateFoldersAndLinksAndRemoveOldFiles.sh
