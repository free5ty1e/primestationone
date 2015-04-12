#!/bin/bash

removeMacFilesFromFilesystem.sh

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
rm ~/RetroPie/roms/settings/pair_ps3_controller_currently_on_usb.sh
rm ~/RetroPie/roms/settings/start_windowed_mode_startx.sh
rm ~/RetroPie/roms/settings/install_mega_module_theme_primestationone_emulationstation.sh

sudo rm /usr/local/bin/megaInstallEntireRetroPieFolderBinaries.sh
sudo rm /usr/local/bin/megaInstallLibretrocoresBinaries.sh
sudo rm /usr/local/bin/megaInstallOtherEmulatorsBinaries.sh

echo Creating required folders...
mkdir ~/temp
mkdir ~/.vice

echo Creating symbolic links for BIOS files...
sudo ln -sv /home/pi/RetroPie/BIOS/gba_bios.bin /opt/retropie/emulators/gpsp/gba_bios.bin
sudo ln -sv /home/pi/RetroPie/BIOS/kick12.rom /opt/retropie/emulators/uae4all/kickstarts/kick12.rom
sudo ln -sv /home/pi/RetroPie/BIOS/kick13.rom /opt/retropie/emulators/uae4all/kickstarts/kick13.rom
sudo ln -sv /home/pi/RetroPie/BIOS/kick20.rom /opt/retropie/emulators/uae4all/kickstarts/kick20.rom
sudo ln -sv /home/pi/RetroPie/BIOS/kick31.rom /opt/retropie/emulators/uae4all/kickstarts/kick31.rom
sudo ln -sv /home/pi/RetroPie/BIOS/Doukutsu.exe /opt/retropie/libretrocores/cavestory/datafiles/Doukutsu.exe