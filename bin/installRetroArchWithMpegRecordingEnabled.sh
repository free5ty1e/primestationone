#!/bin/bash
#echo "Temporarily modifying RetroPie module..."
#sed -i '/gitPullOrClone/c\gitPullOrClone "$md_build" https://github.com/free5ty1e/reicast-emulator.git free5ty1e/rpi2/vmus-in-home-dir' ~/RetroPie-Setup/scriptmodules/emulators/reicast.sh

echo "Requesting a build through official RetroPie calls with the FFMPEG location set..."
sudo ~/RetroPie-Setup/retropie_packages.sh retroarchautoconf

echo "Temporarily modifying the retroarch build script to enable ffmpeg..."
sed -i -e 's/--disable-ffmpeg/--enable-ffmpeg/g' /home/pi/RetroPie-Setup/scriptmodules/emulators/retroarch.sh
sed -i -e 's/.\/configure/PKG_CONFIG_PATH=\/opt\/ffmpeg\/lib\/pkgconfig .\/configure/g' /home/pi/RetroPie-Setup/scriptmodules/emulators/retroarch.sh
sudo ~/RetroPie-Setup/retropie_packages.sh retroarch

echo "Restoring original RetroPie-Setup state..."
pushd ~/RetroPie-Setup
git reset --hard
popd
