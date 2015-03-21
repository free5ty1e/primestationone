#!/bin/bash

message="Disabling SNES emulation rewind feature which may cause massive slowdown just being on..."
echo "$message"
cowsay -f eyes "$message"

sudo cp -vf ~/primestationone/reference/opt/retropie/configs/snes/retroarch.rewindDisabled.cfg /opt/retropie/configs/snes/retroarch.cfg
