#!/bin/bash

function pause()
{
    read -p "$*"
}

cowsay Nuking and Fresh-Installing and Updating RetroPie-Setup...
echo =====================> Now getting the latest RetroPie-Setup script.
pushd ~
sudo rm -rf RetroPie-Setup
git clone --depth=0 git://github.com/petrockblog/RetroPie-Setup.git
cd ~/RetroPie-Setup
git pull
chmod +x retropie_packages.sh
chmod +x retropie_setup.sh
popd
