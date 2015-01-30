#!/bin/bash

cowsay -f hellokitty Installing MEGA.co.nz cloud tools megacmd...
echo =====================> Installing MEGA.co.nz cloud tools megacmd...

pushd ~

echo Installing required depedencies for wheezy MegaTools...
sudo apt-get update && sudo apt-get install -y glib-networking fuse curl wget build-essential libglib2.0-dev libssl-dev libcurl4-openssl-dev libgirepository1.0-dev

#echo Installing 32-bit wheezy version of MegaTools...
#cd /tmp
#wget http://megatools.megous.com/builds/megatools-1.9.91-debian-wheezy-i386.tar.gz
#sudo tar -x -f /tmp/megatools-1.9.91-debian-wheezy-i386.tar.gz -C / --no-overwrite-dir

#echo Installing 64-bit wheezy version of MegaTools...
#cd /tmp
#wget http://megatools.megous.com/builds/megatools-1.9.91-debian-wheezy-amd64.tar.gz
#sudo tar -x -f megatools-1.9.91-debian-wheezy-amd64.tar.gz -C / --no-overwrite-dir

echo Downloading megatools and building from source...

wget http://megatools.megous.com/builds/megatools-1.9.94.tar.gz
tar -x -f megatools-1.9.94.tar.gz
cd megatools-1.9.94
./configure
make
make check
sudo make install
make installcheck

echo MegaTools should now be installed, if there are no errors above.
echo !!!Note: Remeber to escape the ! ...ie. replace the ! with a \! in the mega url.
echo megareg : Register and verify a new mega account
echo megadf : Show your cloud storage space usage/quota
echo megals : List all remote files
echo megamkdir : Create remote directory
echo megarm : Remove remote file or directory
echo megamv : Move and rename remote files
echo megaput : Upload individual files
echo megaget : Download individual files
echo megadl : Download file from a “public” Mega link -- doesn’t require login...
echo megasync : Upload or download a directory tree
echo megafs : Mount remote filesystem locally.

popd
