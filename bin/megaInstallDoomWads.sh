#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
download_install_mega_module_on_the_fly megaDoomWads ~ 101694852 'https://mega.co.nz/#!otxVxDoR!VrRoflAkl2wll4pXM3onfhOLHLLLILRbsYy0D6IIu-w'
reset_permissions_bios_and_roms

rm ./RetroPie/roms/ports/._*
