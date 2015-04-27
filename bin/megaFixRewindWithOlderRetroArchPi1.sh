#!/bin/bash
echo "Must be run with sudo!!"
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
download_install_mega_module_on_the_fly retroarch /opt/retropie/emulators/retroarch 2185513 'https://mega.co.nz/#!VY9DBTxJ!qs-Fclz6YLoIBezrsYFK4fPW9ThTaFWmRhTfUrrRYik'
quickCreateFoldersAndLinksAndRemoveOldFiles.sh
controllerConfigConstruction.sh
rewindGlobalToggleUnset.sh
rewindGlobalLongerCoarseBuffer.sh
