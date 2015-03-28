#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
download_install_mega_module_on_the_fly binsnroms ~ 91520728 'https://mega.co.nz/#!clBmkJpS!OyhzsqVOdJA2wDD5yeDm6IjUucXnt6YQntJhXLthCbI'
reset_permissions_bios_and_roms

cd ~/archive
p7zip -d uae4all.7z
mkdir ~/RetroPie/emulators
cp -rv uae4all ~/RetroPie/emulators/

echo Creating symbolic links for BIOS files...
sudo ln -sv /home/pi/RetroPie/BIOS/gba_bios.bin /opt/retropie/emulators/gpsp/gba_bios.bin
sudo ln -sv /home/pi/RetroPie/BIOS/kick12.rom /opt/retropie/emulators/uae4all/kickstarts/kick12.rom
sudo ln -sv /home/pi/RetroPie/BIOS/kick13.rom /opt/retropie/emulators/uae4all/kickstarts/kick13.rom
sudo ln -sv /home/pi/RetroPie/BIOS/kick20.rom /opt/retropie/emulators/uae4all/kickstarts/kick20.rom
sudo ln -sv /home/pi/RetroPie/BIOS/kick31.rom /opt/retropie/emulators/uae4all/kickstarts/kick31.rom
sudo ln -sv /home/pi/RetroPie/BIOS/Doukutsu.exe /opt/retropie/libretrocores/cavestory/datafiles/Doukutsu.exe
