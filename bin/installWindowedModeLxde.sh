#!/bin/bash

function pause()
{
    read -p "$*"
}

cowsay -f elephant Windowed Mode Startx LXDE...
echo Installing Windowed Mode Startx LXDE...

pushd ~

sudo apt-get update
sudo apt-get -y install lxde
autoStartEmulationstationEnforce.sh
fixStartX.sh

cowsay -f vader You should probably reboot before attempting to start windowed mode startx...

popd

echo Really, you should probably reboot before attempting to use windowed mode...
