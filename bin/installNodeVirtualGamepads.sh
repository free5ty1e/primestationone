#!/bin/bash
cowsay -f calvin Installing node virtual gamepads...
echo Installing node virtual gamepads...

pushd ~

sudo apt-get -y install node
git clone https://github.com/miroof/node-virtual-gamepads
cd node-virtual-gamepads
npm install

#sudo node main.js

popd
