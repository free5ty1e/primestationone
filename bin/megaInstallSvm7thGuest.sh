#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
download_install_mega_module_on_the_fly megaSvm7thGuest ~ 744108780 'https://mega.co.nz/#!2i50kZaD!C9IZyvZZ7o7MgDN5BQ5XPvZOG3veJTs6iGqnQjMRpGU'
reset_permissions_bios_and_roms

rm ./RetroPie/roms/ports/._*
