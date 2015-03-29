#!/bin/bash
installWindowedModeLxde.sh

echo Also reinstalling Bluez5 PS3 driver since LXDE just tried to screw it up...
installBluezPs3Driver.sh
