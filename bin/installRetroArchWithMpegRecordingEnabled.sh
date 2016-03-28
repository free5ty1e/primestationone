#!/bin/bash
#echo "Temporarily modifying RetroPie module..."
#sed -i '/gitPullOrClone/c\gitPullOrClone "$md_build" https://github.com/free5ty1e/reicast-emulator.git free5ty1e/rpi2/vmus-in-home-dir' ~/RetroPie-Setup/scriptmodules/emulators/reicast.sh

echo "Requesting a build through official RetroPie calls with the FFMPEG location set..."
sudo ~/RetroPie-Setup/retropie_packages.sh retroarchautoconf
PKG_CONFIG_PATH=/opt/ffmpeg/lib/pkgconfig sudo ~/RetroPie-Setup/retropie_packages.sh retroarch

#echo "Restoring original RetroPie-Setup state..."
#pushd ~/RetroPie-Setup
#git reset --hard
#popd
