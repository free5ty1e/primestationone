#!/bin/bash

cowsay -f hellokitty Installing MEGA.co.nz cloud tools megacmd...
echo "Installing MEGA.co.nz cloud tools megacmd..."

# lol:
sudo apt install megatools



# megatoolsfilename="megatools-1.9.95"

# pushd ~

# echo "Installing required depedencies for MegaTools..."
# sudo apt-get update && sudo apt-get install -y glib-networking gobject-introspection fuse curl wget build-essential libglib2.0-dev libssl-dev libcurl4-openssl-dev libgirepository1.0-dev libcurl4-gnutls-dev p7zip pv libssl-dev glib-networking pyqt4-dev-tools openssl

# #echo Installing 32-bit wheezy version of MegaTools...
# #cd /tmp
# #wget http://megatools.megous.com/builds/megatools-1.9.91-debian-wheezy-i386.tar.gz
# #sudo tar -x -f /tmp/megatools-1.9.91-debian-wheezy-i386.tar.gz -C / --no-overwrite-dir

# #echo Installing 64-bit wheezy version of MegaTools...
# #cd /tmp
# #wget http://megatools.megous.com/builds/megatools-1.9.91-debian-wheezy-amd64.tar.gz
# #sudo tar -x -f megatools-1.9.91-debian-wheezy-amd64.tar.gz -C / --no-overwrite-dir

# echo Downloading megatools and building from source...

# wget "http://megatools.megous.com/builds/$megatoolsfilename.tar.gz"
# tar -x -f "$megatoolsfilename.tar.gz"
# cd "$megatoolsfilename"
# ./configure
# make
# make check
# sudo make install
# make installcheck
# sudo ldconfig

# echo Cleaning up...
# cd ..
# rm -rf "$megatoolsfilename"
# rm "$megatoolsfilename.tar.gz"

# echo MegaTools should now be installed, if there are no errors above.
# echo !!!Note: Remeber to surround each megadl link with single quotes, and you can download several at once as parameters!
# echo megareg : Register and verify a new mega account
# echo megadf : Show your cloud storage space usage/quota
# echo megals : List all remote files
# echo megamkdir : Create remote directory
# echo megarm : Remove remote file or directory
# echo megamv : Move and rename remote files
# echo megaput : Upload individual files
# echo megaget : Download individual files
# echo megadl : Download file from a “public” Mega link -- doesn’t require login...
# echo megasync : Upload or download a directory tree
# echo megafs : Mount remote filesystem locally.

# popd
