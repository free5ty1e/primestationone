#!/bin/bash

message="Enabling SNES emulation rewind feature which may cause massive slowdown just being on..."
echo "$message"
cowsay -f eyes "$message"

sudo cp -vf ~/primestationone/reference/opt/retropie/configs/megadrive/retroarch.rewindDisabled.cfg /opt/retropie/configs/megadrive/retroarch.cfg
