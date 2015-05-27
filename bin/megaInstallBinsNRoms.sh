#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
download_install_mega_module_on_the_fly binsnroms ~ 120630338 'https://mega.co.nz/#!dlY23DoL!UHj_Kqhce11ubjN9BLjOoju0Ny0ZWIO6PYmQKABmvoM'
reset_permissions_bios_and_roms

cd ~/archive
p7zip -d uae4all.7z
mkdir ~/RetroPie/emulators
cp -rv uae4all ~/RetroPie/emulators/

quickCreateFoldersAndLinksAndRemoveOldFiles.sh
