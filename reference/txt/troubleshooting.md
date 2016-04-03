### Troubleshooting
Some of the previous versions of the PrimeStation One may or may not have inadvertently caused some ownership issues in the user file structure, and / or left unused or outdated scripts lying around where they can cause confusion.  The best way to ensure that things are really set as they should be, and that you have the absolute best starting point to move forward, you should run the following script.  Be prepared to lose your cached gamelists, custom emulationstation input adjustments and general settings:
```
quickResetPrimestationOne.sh
```

##### PS3 controller connection troubleshooting

Sometimes it might take a couple tries of connecting the controller via USB for ~10 seconds to the Primestation, then disconnect and press PS3 button to attempt connection before (especially generic) controllers might start actually trying to pair to the Primestation.  Even once connected, they may not respond without reconnecting a couple more times and possibly restarting the Primestation.  This only seems to occur when connecting many different types of controllers, as I did during testing...


######NOTE:
primeStationOne images / installations older than v0.951alpha can not be automatically updated to the latest by simply running the quick update script.  They must run the following commands to purge and recreate the git repository, since it has been recreated on GitHub for v0.951alpha and later (This is also the same command sequence one should use to install the PrimeStation One over top of a fresh vanilla RetroPie image.  It is all in one line so it is easy to copy / paste into a terminal window SSH session):
```
rm -rf ~/primestationone && pushd ~ && git clone https://github.com/free5ty1e/primestationone.git && popd && ~/primestationone/bin/installPrimeStationOneFiles.sh && quickResetPrimestationOne.sh && installMegaTools.sh && sudo service dphys-swapfile stop && sudo rm /var/swap && installDescent1and2.sh && upgrade2gMinPrimestationToFull.sh
```

ADDITIONALLY, with v0.951alpha comes the decoupling of the primestationone theme from the repo.  The theme will be available separately in the same share as the PrimeStationOne image (below).  The theme no longer overwrites the Simple theme, there is a Primestation theme to select in the EmulationStation menu now.  Using the above command sequence, you will end up with the Primestation One theme installed and selected.

