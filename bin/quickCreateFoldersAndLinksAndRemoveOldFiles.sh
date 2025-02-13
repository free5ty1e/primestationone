#!/bin/bash

#removeMacFilesFromFilesystem.sh

sudo rm -rf RetroPie-Setup/tmp/*
#sudo rm -rf RetroPie-Setup/tmp/build

echo Cleaning up old and outdated scripts...

rm ~/RetroPie/roms/ports/StartXWindowedMode_Login_pi_Password_raspberry.sh
rm ~/RetroPie/roms/ports/StartXWindowedMode.sh

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
rm ~/RetroPie/roms/settings/install_mega_module_mame_37b5_roms.sh
rm ~/RetroPie/roms/settings/install_windowed_mode_startx_lxde.sh
rm ~/RetroPie/roms/settings/first_run_and_reset_primestation_one_not_quick.sh
rm ~/RetroPie/roms/settings/pair_ps3_controller_currently_on_usb.sh
rm ~/RetroPie/roms/settings/start_windowed_mode_startx.sh
rm ~/RetroPie/roms/settings/install_mega_module_theme_primestationone_emulationstation.sh
rm ~/RetroPie/roms/settings/raspberry_pi_configurator_menu.sh
rm ~/RetroPie/roms/settings/reset_primestation_one_quick.sh
rm ~/RetroPie/roms/settings/retro_pie_setup_menu.sh
rm ~/RetroPie/roms/settings/retropie_setup_repo_nuke_and_checkout_fresh.sh
rm ~/RetroPie/roms/settings/show_primestation_one_version.sh
rm ~/RetroPie/roms/settings/update_primestation_one_files_quick.sh
rm ~/RetroPie/roms/settings/install_mega_older_retroarch_to_fix_rewind.sh
rm ~/RetroPie/roms/settings/display_splashscreen_quick_reference.sh
rm ~/RetroPie/roms/settings/audio_mixer_alsamixer.sh
rm ~/RetroPie/roms/settings/manage_wifi.sh
rm ~/RetroPie/roms/settings/update_primestation_one_files_quick.sh
rm ~/RetroPie/roms/settings/wifi_networks.sh
rm ~/RetroPie/roms/settings/z.sh

rm ~/RetroPie/roms/settings/system/upgrade_primestation_minimal_to_full.sh

rm ~/RetroPie/roms/settings/rewind/rewind_enable_GLOBAL.sh
rm ~/RetroPie/roms/settings/rewind/rewind_disable_GLOBAL.sh

rm ~/RetroPie/roms/settings/megaModules/install_mega_module_binaries_pi1.sh
rm ~/RetroPie/roms/settings/megaModules/install_mega_module_binaries_pi2.sh
rm ~/RetroPie/roms/settings/megaModules/install_all_mega_modules.sh
rm ~/RetroPie/roms/settings/megaModules/megaInstallThemePrimeStationOne.sh
rm ~/RetroPie/roms/settings/megaModules/install_mega_Pi1_older_retroarch_to_fix_rewind.sh
rm ~/RetroPie/roms/settings/megaModules/install_mega_Pi2_older_retroarch_to_fix_rewind.sh
rm ~/RetroPie/roms/settings/megaModules/install_mega_module_kodi_with_exodus.sh
rm ~/RetroPie/roms/settings/megaModules/install_mega_module_nes_scrapins.sh

rm ~/RetroPie/roms/settings/system/upgrade_primestation_one_full.sh

rm ~/RetroPie/roms/settings/installs/first_run_and_reset_primestation_one_not_quick.sh

rm ~/RetroPie/BIOS/Doukutsu.exe
sudo rm -rf /opt/retropie/libretrocores/lr-nxengine/datafiles

sudo rm /usr/local/bin/megaInstallEntireRetroPieFolderBinaries.sh
sudo rm /usr/local/bin/megaInstallLibretrocoresBinaries.sh
sudo rm /usr/local/bin/megaInstallOtherEmulatorsBinaries.sh
sudo rm /usr/local/bin/megaFixRewindWithOlderRetroArch.sh
sudo rm /usr/local/bin/retroPieNukeAndCheckoutFresh.sh
sudo rm /usr/local/bin/sixpair
sudo rm /usr/local/bin/rewindGlobalDisable.sh
sudo rm /usr/local/bin/rewindGlobalEnable.sh
sudo rm /usr/local/bin/installPs3DriverQtSixAdWithFakeSupportFromSources.sh
sudo rm /usr/local/bin/installPs3DriverQtSixAdWithGasiaSupportFromSources.sh
sudo rm /usr/local/bin/installPs3GenericFriendlyDriver.sh
sudo rm /usr/local/bin/installPs3ExperimentalGasiaDriver.sh
sudo rm /usr/local/bin/installPs3ExperimentalUniversalGenericFriendlyDriver.sh
sudo rm /usr/local/bin/installPs3ShanWanAndSonyFriendlyDriver.sh
sudo rm /usr/local/bin/upgradePrimestationV1_0000betaAndUpToV1.10beta.sh
sudo rm /usr/local/bin/emulationstation
sudo rm /usr/local/bin/finishPrimestationInstallPi3.sh
sudo rm /usr/local/bin/networkFresh.sh
sudo rm /usr/local/bin/megaFixRewindWithOlderRetroArchPi1.sh
sudo rm /usr/local/bin/megaFixRewindWithOlderRetroArchPi2.sh
sudo rm /usr/local/bin/megaInstallBinariesPi1.sh
sudo rm /usr/local/bin/megaInstallBinariesPi2.sh
sudo rm /usr/local/bin/upgrade2gMinPrimestationToFull.sh
sudo rm /usr/local/bin/megaInstallKodiWithExodus.sh
sudo rm /usr/local/bin/megaInstallKodiWithElysium.sh


rm -v /home/pi/RetroPie/roms/ports/Descent1.sh
rm -v /home/pi/RetroPie/roms/ports/Descent2.sh
rm -v /home/pi/RetroPie/roms/ports/RainbowStreamTwitterClient.sh

echo Creating required folders...
mkdir ~/temp
mkdir ~/.vice
mkdir -p ~/.reicast/data

echo Creating symbolic links for BIOS files...
sudo ln -sv /home/pi/RetroPie/BIOS/gba_bios.bin /opt/retropie/emulators/gpsp/gba_bios.bin
sudo ln -sv /home/pi/RetroPie/BIOS/kick12.rom /opt/retropie/emulators/uae4all/kickstarts/kick12.rom
sudo ln -sv /home/pi/RetroPie/BIOS/kick13.rom /opt/retropie/emulators/uae4all/kickstarts/kick13.rom
sudo ln -sv /home/pi/RetroPie/BIOS/kick20.rom /opt/retropie/emulators/uae4all/kickstarts/kick20.rom
sudo ln -sv /home/pi/RetroPie/BIOS/kick31.rom /opt/retropie/emulators/uae4all/kickstarts/kick31.rom
sudo ln -sv /home/pi/RetroPie/BIOS/cavestory /opt/retropie/libretrocores/lr-nxengine/datafiles
# sudo ln -sv /home/pi/RetroPie/roms/pc /opt/retropie/emulators/rpix86/games
# sudo ln -sv /home/pi/RetroPie/BIOS/dc_boot.bin /home/pi/.reicast/data/dc_boot.bin
# sudo ln -sv /home/pi/RetroPie/BIOS/dc_flash.bin /home/pi/.reicast/data/dc_flash.bin

echo Ensuring retroarch emu configs have their includes as the last line
ensureRetroarchEmuConfigsIncludesAreLast.sh
