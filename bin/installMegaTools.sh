#!/bin/bash

cowsay -f hellokitty Installing MEGA.co.nz cloud tools...
echo =====================> Installing MEGA.co.nz cloud tools...

pushd ~

echo Adding apt repository for MEGAtools Stable...
sudo add-apt-repository -y ppa:megous/ppa

echo Installing MEGAtools Stable...
apt-get update -y && apt-get install -y megatools glib-networking fuse curl

echo If no errors are shown above, MEGATools Stable is probably installed.
echo Commands are:
echo megareg : Register and verify a new mega account
echo megadf : Show your cloud storage space usage/quota
echo megals : List all remote files
echo megamkdir : Create remote directory
echo megarm : Remove remote file or directory
echo megamv : Move and rename remote files
echo megaput : Upload individual files
echo megaget : Download individual files
echo megadl : Download file from a “public” Mega link, doesn’t require login
echo megasync : Upload or download a directory tree
echo megafs : Mount remote filesystem locally.

popd
