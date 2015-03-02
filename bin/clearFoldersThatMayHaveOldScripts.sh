#!/bin/bash

function pause()
{
    read -p "$*"
}

cowsay -f vader Clearing out folders that may have outdated scripts in them...
echo Clearing out folders that may have outdated scripts in them...
sudo rm -rf ~/RetroPie/roms/settings/*
