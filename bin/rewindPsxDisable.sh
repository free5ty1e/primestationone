#!/bin/bash

message="Disabling PSX emulation rewind feature which may cause massive slowdown just being on..."
echo "$message"
cowsay -f eyes "$message"

sudo cp -vf ~/primestationone/reference/opt/retropie/configs/psx/retroarch.rewindDisabled.cfg /opt/retropie/configs/psx/retroarch.cfg
