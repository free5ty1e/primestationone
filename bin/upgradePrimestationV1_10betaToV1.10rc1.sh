#!/bin/bash
sudo RetroPie-Setup/retropie_packages.sh reicast configure
quickUpdatePrimestationOneFiles.sh
megaInstallKodiWithExodus.sh
sudo apt-get purge -y bluetooth
restart
