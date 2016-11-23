#!/bin/bash
cowsay -f calvin Installing node virtual gamepads...
echo "Installing node virtual gamepads..."

# pushd ~

# sudo apt-get -y install node npm
# git clone https://github.com/miroof/node-virtual-gamepads
# cd node-virtual-gamepads
# npm install

# #sudo node main.js

# popd
sudo ~/RetroPie-Setup/retropie_packages.sh virtualgamepad

echo "Correcting Virtual Gamepads' horrible, horrible mistake in not null-terminating their name strings..."

sed -i -- 's/\"Virtual gamepad\"/\"Virtual gamepad\\u0000\"/g' /opt/retropie/supplementary/virtualgamepad/app/virtual_gamepad.*

