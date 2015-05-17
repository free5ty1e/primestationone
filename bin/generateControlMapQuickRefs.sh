#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

echo Generating Nintendo64 emulator Mupen64Plus quickref image...
generateControllerOverlay "/home/pi/quickref_n64_mupen64plus.png" "/home/pi/primestationone/reference/txt/controlsMappingOverlayN64Mupen64Plus.txt" "/home/pi/nothere"

echo Generating Commodore64 emulator VICE quickref image...
generateControllerOverlay "/home/pi/quickref_c64_vice.png" "/home/pi/primestationone/reference/txt/controlsMappingOverlayC64Vice.txt" "/home/pi/nothere"
