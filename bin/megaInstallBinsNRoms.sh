#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
download_install_mega_module_on_the_fly binsnroms ~ 91520728 'https://mega.co.nz/#!clBmkJpS!OyhzsqVOdJA2wDD5yeDm6IjUucXnt6YQntJhXLthCbI'
reset_permissions_bios_and_roms

cd ~/archive
p7zip -d uae4all.7z
mkdir ~/RetroPie/emulators
cp -rv uae4all ~/RetroPie/emulators/

quickCreateFoldersAndLinksAndRemoveOldFiles.sh
