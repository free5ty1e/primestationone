#!/bin/bash

cowsay -f hellokitty Installing ps3 controller driver QtSixAd151...
echo Installing ps3 controller driver QtSixAd151...

pushd ~
rm QtSixA-1.5.1.tar.gz
rm -rf QtSixA-1.5.1
megadl 'https://mega.co.nz/#!RF8RGAJJ!F_vZ-JmB__qJ1KLjpk7LEtj0O8zysb8Fx7ZuJMbb-bA'
installPs3BluetoothDaemon.sh

popd
echo If you saw any errors, you might consider running a quickUpdatePrimestationOneFiles.sh to ensure you have the latest mega dl link in this script...
