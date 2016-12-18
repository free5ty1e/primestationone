#!/bin/bash

cowsay -f elephant "Windowed Mode Startx LXDE..."
echo "Installing Windowed Mode Startx LXDE..."

#pushd ~

#sudo apt-get update
#sudo apt-get -y install lxde
#autoStartEmulationstationEnforce.sh
# fixStartX.sh

sudo ~/RetroPie-Setup/retropie_packages.sh raspbiantools lxde

#cowsay -f vader "You should probably reboot before attempting to start windowed mode startx..."

#popd

#echo "Really, you should probably reboot before attempting to use windowed mode..."
