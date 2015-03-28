#!/bin/bash

message="Disabling NES emulation rewind feature which may cause slowdown just being on..."
echo "$message"
cowsay -f eyes "$message"

sudo cp -vf ~/primestationone/reference/opt/retropie/configs/nes/retroarch.rewindDisabled.cfg /opt/retropie/configs/nes/retroarch.cfg
