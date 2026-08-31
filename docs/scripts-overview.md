# PrimeStation One — `bin/` Scripts Overview

The `bin/` directory holds **~320 standalone shell scripts** that drive almost every feature of the PrimeStation One. This is a high-level map to help you navigate them. Individual scripts are largely self-explanatory from their filenames, and many are surfaced in EmulationStation's menus.

> Scripts are plain POSIX/Bash shell, run with the `pi` user (many call `sudo` internally or expect to be run as root). Install/update-style scripts live here too; see `bin/installPrimeStationOneFiles.sh` for the master installer.

---

## 1. Install & Update (RetroPie / system)

These set up or refresh the core system and RetroPie emulators.

| Script(s) | Purpose |
| --- | --- |
| `installPrimeStationOneFiles.sh` | Master installer for the repo onto the Pi. |
| `actuallyInstallRetroPieBinaries.sh`, `installRetroPieBinaries.sh`, `updateAndInstallRetroPiePackages.sh`, `updateAndInstallDemandingRetroPiePackages.sh`, `installMissingPortsFromRetroPieImage.sh`, `installAllPrimeStationOneEmulatorsFromRetroPie.sh` | Install/update RetroPie and its emulator packages (by binaries or source). |
| `primeStationOneFullSetup_WayTooManyFeatures.sh`, `primeStationOneFirstTimeSetupAndReset.sh`, `finishPrimestationInstall.sh`, `finishinstall.sh` | Full/guided first-run setup. |
| `quickUpdate*.sh`, `reallyQuickUpdate*.sh`, `updatePrimeStationOneFull.sh`, `upgradePrimestation*.sh`, `forceFreshCheckoutAndUpdate*.sh`, `nukePrimestationOneRepoAndCheckoutFresh.sh`, `nukeRetroPieSetupRepoAndCheckoutFresh.sh` | Update / upgrade / repair the repo and RetroPie-Setup checkout. |
| `installAptRuntimePackages.sh`, `installAptCompilingPackages.sh`, `installAptOptionalPackages.sh`, `installPackageUniversal.sh`, `removeUnneededAndOutdatedAptPackages.sh` | Manage apt packages. |

## 2. USB Storage, Files, & File Serving

External USB drive handling and network file serving.

| Script(s) | Purpose |
| --- | --- |
| `installDebianUsbFileServer.sh` | Installs the companion `debianusbfileserver` repo (by-label mounts, Samba, FTP). |
| `installPlexMediaServer.sh` | Installs/configures Plex media server. |
| `01_retropie_copyroms` | `usbmount` hook that syncs ROMs from a mounted drive into `~/RetroPie/roms`. |
| `usbRootFilesystemSetup.sh`, `usbGuidRootFilesystemSetup.sh`, `switchFromUsbBackToSdCardRootFilesystem.sh`, `switchFromSdCardBackToUsbRootFilesystem.sh`, `usbSda1ExpandFilesystem.sh`, `autoExpandFilesystemNextBoot.sh` | Moving the **root filesystem** onto/off a USB drive and expanding partitions (see `reference/txt/usbinstall.md`). |
| `showFolderUsage.sh`, `cleanupTempFiles.sh`, `removeMacFilesFromFilesystem.sh` | Disk housekeeping. |

> **Deep dive:** see [`usb-drive-management.md`](usb-drive-management.md) for how to connect and manage USB media drives without rebooting.

## 3. Controllers — PS3 / PS4 / General

A large family of scripts for pairing and driving Sony controllers and mapping them to emulators.

| Script(s) | Purpose |
| --- | --- |
| `installPs3RecommendedDriver.sh`, `installPs3RecommendedDriverPi5.sh`, `installPs3DriverQtSixAdFromSources.sh`, `installPs3UniversalSonyShanwanGasiaFriendlyDriver.sh`, `installPs3SonyOnlyDriver.sh`, `installPs3ExperimentalGasiaOnlyDriver.sh`, `installPs3GenericDiswoeDriver.sh`, `installPs3RetroPieDriverCorrectly.sh`, `installBluezPs3Driver.sh`, `uninstallPs3Driver.sh` | Install/switch the various PS3 (sixaxis/dualshock3) drivers. |
| `ps3BluetoothEnableLegacyMode.sh`, `ps3BluetoothDisableLegacyMode.sh`, `ps3TrustUsbControllerForBluezBluetooth.sh`, `trustAllEncounteredPs3ControllersBluez5.sh`, `ps3GuidedTrustNewControllerPairFirstTime.sh`, `ps3ForceDriverRestartAfterStartup.sh`, `ps3CreateDefaultSixadProfiles.sh`, `auto-ps3-bluetooth-pair-trust-agent.py`, `auto-agent.py` | PS3 Bluetooth pairing / trust / pairing agents. |
| `installPs4RecommendedDriver.sh`, `ps4AutoPairUsbController.sh` | PS4 (DualShock 4) support. |
| `actuallyConstructControllerConfig.sh`, `controllerConfigConstruction.sh`, `controllerQuickSetup.sh`, `esControllerAutoConfig.sh`, `installLinuxJoystickMapper.sh`, `joystickMapPs3*.sh`, `joystickMapperEnable.sh`, `joy2keytest.sh`, `joytest.sh`, `resetEsInputConfig.sh`, `generateControlMapQuickRefs.sh`, `controlMapArcadeSticks.sh` | Controller configuration, joystick mapping, arcade sticks. |

## 4. Emulator & Per-System Tweaks

Settings and controls mapped to specific emulators.

| Script(s) | Purpose |
| --- | --- |
| `*SetDefaultEmulator.sh` (per system) | Pick the default emulator for a system. |
| `rewind*Enable.sh` / `rewind*Disable.sh` | Toggle RetroArch rewind per system (see also `setRewinds.sh`). |
| `n64SetupPs3Controls.sh`, `dosSetupPs3Controls.sh`, `dreamcastMapPs3ControlsForReicast.py`, `n64SetResolutionTo1280x1024.sh`, `n64AudioOutToAnalog.sh`, `n64AudioOutToHdmi.sh` | Per-system control/AV tweaks. |
| `installC64emulator.sh`, `installSnes9xNextForcedOnPi1.sh`, `installReicastPrimestationEdition.sh`, `installReicastPrimestationExperimentalEdition.sh`, `installMacEmuBasiliskLatest.sh`, `installFofixUpdateRebuild.sh`, `installMpegRecordingCapability.sh` | Install/specialize emulators. |
| `netplayConfigForRetroArchLibretrocoreEmulators.sh` | Configure netplay for libretro cores. |

## 5. Media, Streaming & Cloud

| Script(s) | Purpose |
| --- | --- |
| `megaInstall*.sh`, `megaInstallAllModules.sh`, `megaInstallLoadout128GB.sh` | Install ROM/game collections from the author's MEGA share. |
| `megaCloudBakLogin.sh`, `megaCloudBakClearLogin.sh`, `megaCloudBackupSaveStatesAndSrams.sh`, `megaCloudRestoreSaveStatesAndSrams.sh`, `megaCloudSyncSaveStatesAndSrams.sh`, `installMegaTools.sh` | Cloud save/save-state backup to Mega. |
| `installKodi.sh`, `installRainbowstream.sh`, `installGoAndAnsize.sh` | Media / misc tooling. |

## 6. Network, WiFi, Bluetooth

| Script(s) | Purpose |
| --- | --- |
| `bluetoothPairKeyboard.sh`, `bluetoothPairMouse.sh`, `bluetoothClearAllPairings.sh`, `bluetoothChangeAdapterMacAddress.sh`, `installBluetoothMacAddressChanger.sh` | Bluetooth keyboard/mouse/PS3 pairing. |
| `fixWifi.sh`, `wifi`, `speedowifi.sh`, `installCronUpdateForSysStatusHomepage.sh`, `iprefresh.sh` | Network/WiFi config. |

## 7. System, Startup & Monitoring

| Script(s) | Purpose |
| --- | --- |
| `manageStartupServices.sh`, `stopServicesForEmulation.sh`, `autoStartEmulationstationEnforce.sh` | Services / auto-start behavior. |
| `clockmonitor.sh`, `clockpi.sh`, `pitemp`, `pitemp.sh`, `pytemp.py`, `showCpuSpeed.sh`, `piStressTest.sh`, `underclockpi.sh`, `pichipfreqs.sh` | Clock / temp / CPU monitoring. |
| `hdmiAudioFix.sh`, `hdmiAudioFixDisable.sh`, `fixStartX.sh`, `switchToWindowManager*.sh`, `startWindowedMode.sh`, `installWindowedModeLxde.sh` | Display / audio / window manager. |
| `reinstallBashWelcomeTweak.sh`, `displaySplashscreenWithTimeout.sh`, `downloadLatestPrimestationOneSplashscreen.sh`, `downloadLatestPrimestationOneStartupVideo.sh`, `updateSplashscreenTextOverlay.sh`, `updateSplashscreenVersion.sh`, `showPrimestationOneVersion.sh` | Splash / welcome / version. |
| `honeypot*.sh` | Simple fake-credential honeypot helpers. |

## 8. ROM / Save Housekeeping

| Script(s) | Purpose |
| --- | --- |
| `syncRetroPieRomsAndBiosAndConfigs.sh` (`reference/scripts/`) | Sync ROMs/bios/configs. |
| `setupRomsSymlink.sh` | Set up ROM folder symlinks to a USB drive. |
| `renameAllRomsAndSavesToNewEsFriendlyNaming.sh`, `removeNsfwRoms.sh`, `scrapeAllSystems.sh`, `installBlankGamelists.sh`, `clearFoldersThatMayHaveOld*.sh` | ROM library management / scraping / cleaning. |
| `autoSaveAndRestoreStatesEnable/Disable*.sh` | Toggle save-state auto save/restore. |

---

## Notes for contributors

- Scripts are **executable** (`chmod +x`); `fixPermissionsAndSetExecutableBits.sh` repairs permissions/exec bits.
- Many scripts call one another by bare name — they rely on the scripts being on `PATH` (installed by `installPrimeStationOneFiles.sh`).
- Filenames are intentionally verbose and self-describing; when in doubt, read the file header.
- The `reference/` tree stores static configs and older reference material (see `reference/txt/*.md` for topic guides like wifi, kodi, troubleshooting).