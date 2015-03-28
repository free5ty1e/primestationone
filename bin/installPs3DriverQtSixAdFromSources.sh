#!/bin/bash

cowsay -f bud-frogs Installing PS3 driver QtSixAd and sixpair from sources...
echo Installing Sixad PS3 sixaxis controller bluetooth pairing daemon qtsixad and compatible bluez from apt...
pushd ~

sudo apt-get -y install bluez-utils bluez-compat bluez-hcidump checkinstall libusb-dev libbluetooth-dev joystick
cleanupTempFiles.sh

mkdir temp
cd temp
mkdir ps3driver
cd ps3driver
wget -nv http://www.pabr.org/sixlinux/sixpair.c -O "sixpair.c"
wget -O- -q http://sourceforge.net/projects/qtsixa/files/QtSixA%201.5.1/QtSixA-1.5.1-src.tar.gz | tar -xvz --strip-components=1

#patch -p1 <<\_EOF_
#--- a/sixad/shared.h	2011-10-12 03:37:38.000000000 +0300
#+++ b/sixad/shared.h	2012-08-14 19:30:12.190379004 +0300
#@@ -18,6 +18,8 @@
##ifndef SHARED_H
##define SHARED_H
#
#+#include <unistd.h>
#+
#struct dev_led {
#bool enabled;
#bool anim;
#_EOF_

echo Building ps3 driver...
gcc -o sixpair sixpair.c -lusb
cd sixad
make clean
make

echo Instaling ps3 driver...
sudo mkdir -p /var/lib/sixad/profiles
sudo cp -v ~/primestationone/reference/var/lib/sixad/profiles/* /var/lib/sixad/profiles/
sudo checkinstall -y --fstrans=no
sudo update-rc.d sixad defaults


#wget -nv http://www.pabr.org/sixlinux/sixpair.c -O "sixpair.c"
#wget -O- -q http://sourceforge.net/projects/qtsixa/files/QtSixA%201.5.1/QtSixA-1.5.1-src.tar.gz | tar -xvz
##--strip-components=1
#
#sudo gcc -o sixpair sixpair.c -lusb
#pushd QtSixA-1.5.1/sixad
#sudo make clean
#sudo make CXX="g++-4.6" CXXFLAGS="-O2"
##sudo make install
#sudo mkdir -p /var/lib/sixad/profiles
#sudo checkinstall -y --fstrans=no
#sudo update-rc.d sixad defaults
#
#popd
##sudo rm -rf QtSixA-1.5.1


popd
