#!/bin/bash
moduleToModify="/home/pi/RetroPie-Setup/scriptmodules/libretrocores/lr-snes9x-next.sh"
echo "Temporarily modifying RetroPie module $moduleToModify so it will allow building on a Pi1..."
sed -i.backup '/rp_module_flags/d' "$moduleToModify"

echo "Requesting a build of snes-9x-next through official RetroPie calls..."
sudo ~/RetroPie-Setup/retropie_packages.sh lr-snes9x-next

echo "Restoring original RetroPie-Setup state..."
pushd ~/RetroPie-Setup
git reset --hard
popd
