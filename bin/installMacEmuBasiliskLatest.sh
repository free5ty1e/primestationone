#!/bin/bash

echo Now checking out and building the latest Basilisk II 68k Mac emulator.
cd ~
sudo apt-get install -y git libsdl1.2-dev autoconf libgtk2.0-dev libxxf86dga-dev libxxf86vm-dev libesd0-dev
git clone http://github.com/cebix/macemu
cd ~/macemu
git pull
cd ~/macemu/BasiliskII/src/Unix
#sudo aclocal ; autoconf
#sudo autoreconf -I ./m4
#sudo ./configure --enable-sdl-video --enable-sdl-audio --disable-vosf --disable-jit-compiler --without-gtk
#sudo ./configure --enable-sdl-video --enable-sdl-audio --disable-vosf --disable-jit-compiler
#sudo ./autogen.sh --enable-sdl-video --enable-sdl-audio --disable-vosf --disable-jit-compiler

#sudo ./autogen.sh --enable-sdl-video --enable-sdl-audio --disable-vosf --disable-jit-compiler
sudo ./autogen.sh
sudo make install
