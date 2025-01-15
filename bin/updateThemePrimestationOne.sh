#!/bin/bash

message="Updating Primestation One theme..."
echo "$message"
cowsay -f flaming-sheep "$message"

echo Checking to see if the theme and repo exist locally, if not we will install it!
if [ -d "/etc/emulationstation/themes/primestation" ] && [ -d "/home/pi/primestationone-estheme" ]; then
    echo Theme is already installed!  Checking to see if any changes exist upstream that need installing...
    pushd ~/primestationone-estheme
    git fetch
    headsha=$(git rev-parse HEAD)
    upstreamsha=$(git rev-parse @{u})
    if [ "$headsha" != "$upstreamsha" ]
    then
        echo Changes detected upstream!  Updating...
        git pull
        ./installToPrimestationOne.sh
    else
        echo No changes exist upstream, no need to perform any update operations!
    fi
    echo Setting emulationstation to use the PrimeStation One Theme with the latest recommended base config...
    cp -v ~/primestationone/reference/.emulationstation/es_settings.primestationThemeWithFavs.cfg ~/.emulationstation/es_settings.cfg    
    popd
else
    installThemePrimestationOne.sh
fi
