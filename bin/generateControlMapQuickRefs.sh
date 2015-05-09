#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

echo Generating Nintendo64 emulator Mupen64Plus quickref image...
generateControllerOverlay "~/quickref_n64_mupen64plus.png" "~/primestationone/reference/txt/controlsMappingOverlayN64Mupen64Plus.txt" ""

echo Generating Commodore64 emulator VICE quickref image...
generateControllerOverlay "~/quickref_c64_vice.png" "~/primestationone/reference/txt/controlsMappingOverlayC64Vice.txt" ""
