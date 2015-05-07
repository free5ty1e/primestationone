#!/bin/bash

cowsay -f dragon Installing Linux Joystick Mapper...
echo Installing Linux Joystick Mapper
#sayWithGoogle Now installing Linux Joystick Mapper you have no chance to survive make your time
pushd ~
wget 'http://downloads.sourceforge.net/project/linuxjoymap/joymap-0.2.tar.gz'
tar xfvz joymap-0.2.tar.gz
cd joymap-0.2
make clean
make all
sudo make install
popd
