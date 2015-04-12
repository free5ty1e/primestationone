#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
download_install_mega_module_on_the_fly binsnroms ~ 91872109 'https://mega.co.nz/#!B8oDnRIR!TH2bqSgQLB9r4nhL3zz47gM1sW_wsUZXoPifp6f0338'
reset_permissions_bios_and_roms

cd ~/archive
p7zip -d uae4all.7z
mkdir ~/RetroPie/emulators
cp -rv uae4all ~/RetroPie/emulators/

quickCreateFoldersAndLinksAndRemoveOldFiles.sh
