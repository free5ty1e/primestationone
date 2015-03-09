#!/bin/bash

cowsay -f hellokitty Installing all mega modules and mega tools...
echo =====================> Installing all mega modules and mega tools...

clearFoldersThatMayHaveOldBinsNRoms.sh

installMegaTools.sh
megaInstallEntireRetroPieFolderBinaries.sh
megaInstallPs3DriverQtSixAd151.sh
megaInstallBinsNRoms.sh
megaInstallBinsNRomsLarge.sh
megaInstallThemePrimeStationOne.sh
