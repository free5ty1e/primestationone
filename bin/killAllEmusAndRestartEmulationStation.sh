#!/bin/bash
echo "Killing all emulators and restarting emulationstation -- Panic Button!"

killall mupen64plus
killall emulationstation
killall retroarch
killall reicast
killall kodi_v7.bin
killall xroar
killall vice

emulationstation 2>&1 > /dev/tty1 &
