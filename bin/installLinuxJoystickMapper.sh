#!/bin/bash

cowsay -f dragon Installing Linux Joystick Mapper...
echo =====================> Installing Linux Joystick Mapper
#sayWithGoogle Now installing Linux Joystick Mapper you have no chance to survive make your time
pushd ~
tar xfvz joymap-0.2.tar.gz
cd joymap-0.2
sudo make clean
sudo make all
popd
