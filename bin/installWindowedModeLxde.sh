#!/bin/bash

cowsay -f elephant "Windowed Mode Startx LXDE..."
echo "Installing Windowed Mode Startx LXDE..."

#pushd ~

#sudo apt-get update
#sudo apt-get -y install lxde
#autoStartEmulationstationEnforce.sh
# fixStartX.sh

# sudo ~/RetroPie-Setup/retropie_packages.sh raspbiantools lxde
sudo apt-get install --no-install-recommends lxde
sudo apt-get install xorg raspberrypi-ui-mods rpi-chromium-mods

# echo "Adding latest mono-xsp4 key server to repositories and performing update && upgrade to enable install of mono v4+ (see http://www.mono-project.com/docs/getting-started/install/linux/ )..."
# sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
# echo "deb http://download.mono-project.com/repo/debian wheezy main" | sudo tee /etc/apt/sources.list.d/mono-xamarin.list
# sudo apt-get update
# sudo apt-get -y upgrade
# echo "Installing prerequisites in order for mono-xsp4..."
# sudo apt-get install -y libmono-system-web4.0-cil
# sudo apt-get install -y mono-devel
# echo "Actually installing mono-xsp4..."
# sudo apt-get -y install mono-xsp4

# echo "Installing and enabling RealVNC server and some other handy gui packages..."
# sudo apt-get -y install realvnc-vnc-server gedit

# sudo systemctl enable vncserver-x11-serviced.service
# sudo systemctl start vncserver-x11-serviced.service

# echo "Enabling virtual RealVNC server too..."
# sudo systemctl enable vncserver-virtuald.service
# sudo systemctl start vncserver-virtuald.service

echo "Setting up new EmulationStation entry for Desktop..."
mkdir /home/pi/RetroPie/roms/desktop
#cp RetroPie/roms/ports/StartXWindowedMode.sh RetroPie/roms/desktop/Desktop.sh
cp RetroPie/roms/ports/Desktop.sh RetroPie/roms/desktop/Desktop.sh

#cowsay -f vader "You should probably reboot before attempting to start windowed mode startx..."

#popd

#echo "Really, you should probably reboot before attempting to use windowed mode..."
