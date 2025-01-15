#!/bin/bash

#If primestation theme is installed, reset using that one in the settings.  Otherwise, use simple theme
if [ -d /etc/emulationstation/themes/primestation ]; then
    cp -v ~/primestationone/reference/.emulationstation/es_settings.primestationThemeWithFavs.cfg ~/.emulationstation/es_settings.cfg
else
    cp -v ~/primestationone/reference/.emulationstation/es_settings.simpletheme.cfg ~/.emulationstation/es_settings.cfg
fi

cp -v ~/primestationone/reference/.bashrc ~/
cp -v ~/primestationone/reference/.basilisk_ii_prefs ~/

echo "Configuring MAME special emulator launchers..."
sudo cp -rv ~/primestationone/reference/opt/retropie/configs/mame* /opt/retropie/configs/

resetEsInputConfig.sh
resetKodiConfig.sh

#sudo cp -vr /home/pi/primestationone/reference/opt/retropie/configs /opt/retropie/
