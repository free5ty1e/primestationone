#!/bin/bash

echo "Removing PrimeStation One advanced / potentially harmful menu items from this unit..."

# pushd ~/primestationone
# cp -vr RetroPie/* ~/RetroPie/
# popd

rm -rf ~/RetroPie/roms/settings/megaModules
rm -rf ~/RetroPie/roms/settings/audio
rm -rf ~/RetroPie/roms/settings/cloudBackup
rm -rf ~/RetroPie/roms/settings/emulatorSettings
rm -rf ~/RetroPie/roms/settings/installs
rm -rf ~/RetroPie/roms/settings/bluetooth
rm -rf ~/RetroPie/roms/settings/controller
rm -rf ~/RetroPie/roms/settings/hello_pi
rm -rf ~/RetroPie/roms/settings/system
