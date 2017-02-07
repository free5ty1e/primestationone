#!/bin/bash

pushd ~

nukeRetroPieSetupRepoAndCheckoutFresh.sh

sudo RetroPie-Setup/retropie_packages.sh raspbiantools apt_upgrade

#TODO: Need to reboot and have the next steps continue after reboot as a one-shot init?  Maybe, maybe not...

sudo RetroPie-Setup/retropie_packages.sh setup update_packages

installPs3RecommendedDriver.sh

nukePrimestationOneRepoAndCheckoutFresh.sh

quickUpdatePrimestationOneFiles.sh

installKodi.sh

sudo RetroPie-Setup/retropie_packages.sh raspbiantools package_cleanup 

popd

read -p "Press any key to continue rebooting... " -n1 -s
restart
