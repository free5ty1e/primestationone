#!/bin/bash

message="Enabling NES emulation rewind feature which may cause slowdown just being on..."
echo "$message"
cowsay -f eyes "$message"

sudo cp -vf ~/primestationone/reference/opt/retropie/configs/n64/retroarch.rewindEnabled.cfg /opt/retropie/configs/n64/retroarch.cfg
