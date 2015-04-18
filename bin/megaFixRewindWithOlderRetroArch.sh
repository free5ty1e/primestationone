#!/bin/bash
echo "Must be run with sudo!!"
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
download_install_mega_module_on_the_fly retroarch /opt/retropie/emulators/retroarch 2214091 'https://mega.co.nz/#!hQsQBTLa!H7R1_gK8OxzqOLYYByYB4DT7W69vqafiA83qe0pZnb4'
quickCreateFoldersAndLinksAndRemoveOldFiles.sh
