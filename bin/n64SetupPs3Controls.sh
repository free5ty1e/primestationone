#!/bin/bash
echo "Setting mupen64plus PS3 controls so PS3 button can exit emulator..."
source "/home/pi/RetroPie-Setup/scriptmodules/helpers.sh"
source "/home/pi/RetroPie-Setup/scriptmodules/inifuncs.sh"
iniConfig " = " "" "/opt/retropie/configs/n64/mupen64plus.cfg"

## Joystick event string for stopping the emulator
iniSet "Joy Mapping Stop" "\"J0B16\""

## Joystick event string for switching between fullscreen/windowed modes
iniSet "Joy Mapping Fullscreen" "\"\""

## Joystick event string for saving the emulator state
iniSet "Joy Mapping Save State" "\"J0B2\""

## Joystick event string for loading the emulator state
iniSet "Joy Mapping Load State" "\"J0B1\""

## Joystick event string for advancing the save state slot
iniSet "Joy Mapping Increment Slot" "\"J0B0\""

## Joystick event string for taking a screenshot
iniSet "Joy Mapping Screenshot" "\"\""

## Joystick event string for pausing the emulator
iniSet "Joy Mapping Pause" "\"\""

## Joystick event string for muting/unmuting the sound
iniSet "Joy Mapping Mute" "\"\""

## Joystick event string for increasing the volume
iniSet "Joy Mapping Increase Volume" "\"\""

## Joystick event string for decreasing the volume
iniSet "Joy Mapping Decrease Volume" "\"\""

## Joystick event string for fast-forward
iniSet "Joy Mapping Fast Forward" "\"J0B9\""

## Joystick event string for pressing the game shark button
iniSet "Joy Mapping Gameshark" "\"\""

cp -fv /home/pi/primestationone/reference/opt/retropie/configs/n64/InputAutoCfg.ini /opt/retropie/configs/n64/

echo "Disabling RetroPie autoconfiguration of n64 hotkeys in favor of Primestation PS3 controls..."
iniConfig " = " "" "/opt/retropie/configs/all/autoconf.cfg"

iniSet "mupen64plus_hotkeys" "\"0\""
