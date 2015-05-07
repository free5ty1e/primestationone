#!/bin/bash
echo Enabling mapper now...
sudo rmmod uinput
sudo modprobe uinput
sudo reserve_js
