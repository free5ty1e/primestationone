#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

quickUpdatePrimestationOneFiles.sh

RETROPIE_PACKAGE_NAMES=(
    # new for v2.00rc5:
    minivmac
    love-0.10.2
    opentyrian
    xrick
    cdogs-sdl
    dsda-doom
    ionfury
    jumpnbump
    mysticmine
    uqm
    vvvvvv
    yquake2
)


echo "Installing new packages for rc5..."
retropieInstallPackageList RETROPIE_PACKAGE_NAMES
