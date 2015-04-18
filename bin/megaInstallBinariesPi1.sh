#!/bin/bash
echo "Must be run with sudo!!"
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
download_install_mega_module_on_the_fly retropie /opt/retropie 214755784 'https://mega.co.nz/#!sJdlFBzT!kaTeZNoQ_I22aeoYiepmbyBB6flNiWZYgUBnviM-Mi4'
quickCreateFoldersAndLinksAndRemoveOldFiles.sh
controllerConfigConstruction.sh
rewindGlobalEnable.sh
rewindGlobalLongerCoarseBuffer.sh
