#!/bin/bash
echo "Must be run with sudo!!"
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
rm -rf /opt/retropie
download_install_mega_module_on_the_fly retropie /opt/retropie 223540275 'https://mega.co.nz/#!QBlEiLKD!l3dWZ1_pYfy6sG4bPXcMp_k15loP8BEgbtBbbYiycvo'
quickCreateFoldersAndLinksAndRemoveOldFiles.sh
controllerConfigConstruction.sh
rewindGlobalEnable.sh
rewindGlobalLongerCoarseBuffer.sh
