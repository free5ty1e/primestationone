#!/bin/bash

function pause()
{
    read -p "$*"
}

cowsay -f vader Clearing out folders that may have outdated binsnroms in them...
echo Clearing out folders that may have outdated binsnroms in them...
sudo rm -rf ~/RetroPie/roms/nes/*.nes
sudo rm -rf ~/RetroPie/roms/nes/*.NES
sudo rm -rf ~/RetroPie/roms/snes/*.smc
sudo rm -rf ~/RetroPie/roms/n64/*.v64
sudo rm -rf ~/RetroPie/roms/psx/*.bin
sudo rm -rf ~/RetroPie/roms/psx/*.cue
