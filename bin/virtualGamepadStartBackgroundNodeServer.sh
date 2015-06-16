#!/bin/bash
echo Starting virtual gamepad node server in background...
pushd ~/node-virtual-gamepads
sudo node main.js &
popd
