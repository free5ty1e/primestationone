#!/bin/bash
moduleToModify="~/RetroPie-Setup/scriptmodules/emulators/reicast.sh"
echo "Temporarily modifying RetroPie module $moduleToModify so it will pull from the special Primstation repo..."
sed -i '/gitPullOrClone/c\gitPullOrClone "$md_build" https://github.com/free5ty1e/reicast-emulator.git free5ty1e/ps3-controller-mappings' "$moduleToModify"

echo "Requesting a build of snes-9x-next through official RetroPie calls..."
sudo ~/RetroPie-Setup/retropie_packages.sh reicast

echo "Restoring original RetroPie-Setup state..."
pushd ~/RetroPie-Setup
git reset --hard
popd
