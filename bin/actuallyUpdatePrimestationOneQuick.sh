#!/bin/bash

function update_primestation() {
    echo Installing PrimeStationOne files to their proper locations....
    bin/installPrimeStationOneFiles.sh

#    installGoAndAnsize.sh

    updateSplashscreenVersion.sh

    controllerConfigConstruction.sh

    updateThemePrimestationOne.sh

    cleanupTempFiles.sh

    quickCreateFoldersAndLinksAndRemoveOldFiles.sh

    echo To update RetroPie-Setup stuffs, do it from the retropie_setup.sh menu as it is not just a simple git pull...

    #echo Updating latest RetroPie-Setup files from git repo...
    #cd ~/RetroPie-Setup
    #sudo git pull
    #cd ~

    #echo Launching mplayer config 4 pi script...
    #mplayerConfigForPi.sh

    #echo Installing system status page auto updater cronjob...
    #installCronUpdateForSysStatusHomepage.sh

    #echo Installing PrimeStation One onReboot autoupdater cronjob...
    #installCronRebootAutoQuickUpdatePrimeStationOne.sh
}

message="QuickUpdating the Primestation One!!"
echo "$message"
cowsay -f stimpy "$message"

echo Checking to see if the repo exists locally, if not we will retrieve it!
if [ -d "~/primestationone" ]
then
    echo Primestation One local git repository now exists!  Checking to see if any changes exist upstream that need installing...
    pushd ~/primestationone
    headsha=$(git rev-parse HEAD)
    upstreamsha=$(git rev-parse @{u})
    if [ "$headsha" != "$upstreamsha" ]
    then
        echo Changes detected upstream!  Updating...
        git pull
        update_primestation
    else
        echo No changes exist upstream, no need to perform any update operations!
    fi
    popd
else
    pushd ~
    git clone https://github.com/free5ty1e/primestationone.git
    popd
    pushd ~/primestationone
    update_primestation
    popd
fi

