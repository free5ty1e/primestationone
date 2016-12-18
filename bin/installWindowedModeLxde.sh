#!/bin/bash

cowsay -f elephant "Windowed Mode Startx LXDE..."
echo "Installing Windowed Mode Startx LXDE..."

#pushd ~

#sudo apt-get update
#sudo apt-get -y install lxde
#autoStartEmulationstationEnforce.sh
# fixStartX.sh

sudo ~/RetroPie-Setup/retropie_packages.sh raspbiantools lxde

echo "Installing and enabling RealVNC server..."
sudo apt-get -y install realvnc-vnc-server

sudo systemctl enable vncserver-x11-serviced.service
sudo systemctl start vncserver-x11-serviced.service

echo "Enabling virtual RealVNC server too..."
sudo systemctl enable vncserver-virtuald.service
sudo systemctl start vncserver-virtuald.service

echo "Setting up new EmulationStation entry for Desktop..."
mkdir /home/pi/RetroPie/roms/desktop
cp RetroPie/roms/ports/StartXWindowedMode.sh RetroPie/roms/desktop/Desktop.sh

#cowsay -f vader "You should probably reboot before attempting to start windowed mode startx..."

#popd

#echo "Really, you should probably reboot before attempting to use windowed mode..."
