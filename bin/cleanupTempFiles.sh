#!/bin/bash

echo Cleaning up temp files...
sudo apt-get -y autoremove
sudo apt-get clean
sudo rm -rf RetroPie-Setup/tmp/*

echo Cleaning up old and outdated scripts...
rm ~/RetroPie/roms/settings/install_all_mega_modules.sh
rm ~/RetroPie/roms/settings/install_mega_module_binsnroms_large.sh
rm ~/RetroPie/roms/settings/install_mega_module_binsnroms.sh
rm ~/RetroPie/roms/settings/install_mega_module_entire_retropie_binaries_folder.sh
rm ~/RetroPie/roms/settings/install_mega_module_mapped_emulator_binaries.sh
rm ~/RetroPie/roms/settings/install_mega_module_other_emulator_binaries.sh
rm ~/RetroPie/roms/settings/install_mega_tools_for_module_installs.sh
rm ~/RetroPie/roms/settings/install_mega_module_entire_retropie_binaries_folder.sh
rm ~/RetroPie/roms/settings/install_mega_module_other_emulator_binaries.sh
rm ~/RetroPie/roms/settings/install_mega_module_mapped_emulator_binaries.sh
rm ~/RetroPie/roms/settings/install_windowed_mode_startx_lxde.sh
rm ~/RetroPie/roms/settings/first_run_and_reset_primestation_one_not_quick.sh


sudo rm /usr/local/bin/megaInstallEntireRetroPieFolderBinaries.sh
sudo rm /usr/local/bin/megaInstallLibretrocoresBinaries.sh
sudo rm /usr/local/bin/megaInstallOtherEmulatorsBinaries.sh

df -h
