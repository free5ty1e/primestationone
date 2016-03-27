#!/bin/bash

source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
fancy_console_message "Installing PS3 driver QtSixAd fork with fake controller support and sixpair from sources..." "bud-frogs"

sudo apt-get -y install bluez-utils bluez-compat bluez-hcidump checkinstall libusb-dev libbluetooth-dev joystick

cleanupTempFiles.sh

echo Entering working folder to build in...
md_build="/tmp"
pushd "$md_build"

echo Preparing target installation folder...
md_inst="/home/pi/sixadgasia"
mkdir -p "$md_inst"

#wget -nv http://www.pabr.org/sixlinux/sixpair.c -O "$md_build/sixpair.c"

echo Obtaining sources...
git clone https://github.com/yonirom/qtsixa.git
#wget -O- -q http://sourceforge.net/projects/qtsixa/files/QtSixA%201.5.1/QtSixA-1.5.1-src.tar.gz | tar -xvz --strip-components=1

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
#    bool enabled;
#    bool anim;
#_EOF_
#
echo Altering uinput.cpp to not include the mac address in the controller name because that gets in the way of retroarch autoconfiguring matching controller names...
sed -i 's/strcpy(dev_name, "PLAYSTATION(R)3 Controller (");/strcpy(dev_name, "PLAYSTATION(R)3 Controller");/g' "$md_build/qtsixa/sixad/uinput.cpp"
sed -i 's/strcat(dev_name, mac);//g' "$md_build/qtsixa/sixad/uinput.cpp"
sed -i 's/strcat(dev_name, ")");//g' "$md_build/qtsixa/sixad/uinput.cpp"

echo Compiling driver...
cd qtsixa
make clean
make

echo Installing driver...
sudo checkinstall -y --fstrans=no
sudo update-rc.d sixad defaults

# If a bluetooth dongle is connected set state up and enable pscan
cat > "$md_inst/bluetooth.sh" << _EOF_
#!/bin/bash
/usr/bin/hciconfig hci0 up
if hciconfig | grep -q "BR/EDR"; then
hciconfig hci0 pscan
fi
_EOF_

chmod +x "$md_inst/bluetooth.sh"

# If a PS3 controller is connected over usb check if bluetooth dongle exits and start sixpair
cat > "$md_inst/ps3pair.sh" << _EOF_
#!/bin/bash
if hciconfig | grep -q "BR/EDR"; then
hciconfig hci0 pscan
sixpair
fi
_EOF_

chmod +x "$md_inst/ps3pair.sh"

# udev rule for bluetooth dongle
sudo bash -c 'cat > /etc/udev/rules.d/10-local.rules' << _EOF_
# Set bluetooth power up
ACTION=="add", KERNEL=="hci0", RUN+="$md_inst/bluetooth.sh"
_EOF_

# udev rule for ps3 controller usb connection
sudo bash -c 'cat > /etc/udev/rules.d/99-sixpair.rules' << _EOF_
# Pair if PS3 controller is connected
DRIVER=="usb", SUBSYSTEM=="usb", ATTR{idVendor}=="054c", ATTR{idProduct}=="0268", RUN+="$md_inst/ps3pair.sh"
_EOF_

# add default sixad settings
sudo bash -c 'cat > /var/lib/sixad/profiles/default' << _EOF_
enable_leds 1
enable_joystick 1
enable_input 0
enable_remote 0
enable_rumble 1
enable_timeout 0
led_n_auto 1
led_n_number 0
led_anim 1
enable_buttons 1
enable_sbuttons 0
enable_axis 1
enable_accel 0
enable_accon 0
enable_speed 0
enable_pos 0
_EOF_

# Start sixad daemon
sudo service sixad start

echo Cleaning up...
sudo rm -rf "$md_build/qtsixa"

popd
