#!/bin/bash

message="Enabling PSX emulation rewind feature which may cause slowdown just being on..."
echo "$message"
cowsay -f eyes "$message"

sudo cp -vf ~/primestationone/reference/opt/retropie/configs/psx/retroarch.rewindEnabled.cfg /opt/retropie/configs/psx/retroarch.cfg
