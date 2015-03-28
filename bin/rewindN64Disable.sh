#!/bin/bash

message="Disabling SNES emulation rewind feature which may cause massive slowdown just being on..."
echo "$message"
cowsay -f eyes "$message"

sudo cp -vf ~/primestationone/reference/opt/retropie/configs/n64/retroarch.rewindDisabled.cfg /opt/retropie/configs/n64/retroarch.cfg
