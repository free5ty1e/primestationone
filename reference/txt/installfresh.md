####Installing over a fresh RetroPie image:
```
rm -rf ~/primestationone && pushd ~ && git clone https://github.com/free5ty1e/primestationone.git && popd && ~/primestationone/bin/installPrimeStationOneFiles.sh && quickResetPrimestationOne.sh && installMegaTools.sh && installPs3SonyOnlyDriver.sh && finishPrimestationInstall.sh
```

...you will end up on the RetroPie PS3 driver installation menu, choose your driver here.  The normal driver works great with Sony controllers.  My fork of qtsixad does not work on Jessie yet, so I am experimenting with this.

#####Installing on a fresh RetroPie image (Pi3):
Perform the above command, and then:
```
finishPrimestationInstallPi3.sh
```


