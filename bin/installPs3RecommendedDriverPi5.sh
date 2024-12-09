#!/bin/bash

# Install bluez5 auto pairing capabilities:
echo "Setting up automatic bluez5 standard bluetooth stack compatible sixaxis trust upon pair request..."

sudo apt-get update
sudo apt-get -y install bluez-tools
sudo cp -vf /home/pi/primestationone/reference/etc/systemd/system/autobtpair2024.service /etc/systemd/system/
sudo systemctl enable autobtpair2024
sudo systemctl enable autobtpair2024.service
sudo service autobtpair2024 status

# sudo sed -i -- 's/#deb-src/deb-src/g' /etc/apt/sources.list && sudo sed -i -- 's/# deb-src/deb-src/g' /etc/apt/sources.list
# sudo apt-get update
# sudo apt-get -y install libbluetooth-dev bluez-tools python3-full pipx
# pipx install wheel
# pipx install pybluez
# pushd ~
# rm bluezutils.py
# wget http://raw.githubusercontent.com/pauloborges/bluez/master/test/bluezutils.py
# sudo cp -vf bluezutils.py /usr/local/bin/

# sudo cp -vf /home/pi/primestationone/reference/etc/systemd/system/autobtpair.service /etc/systemd/system/
# sudo systemctl enable autobtpair
# sudo systemctl enable autobtpair.service
# sudo service autobtpair status


# grep -q -F 'auto-agent.py &' /home/pi/.bashrc || echo 'auto-agent.py &' >> /home/pi/.bashrc
# cat /home/pi/.bashrc

# if [ "`tail -n1 /etc/rc.local`" != "exit 0" ]; then
# 	echo "Last line of rc.local is not exit 0... not modifying rc.local for now..."
# #TODO: find exit 0 and insert line before it...
# else
# 	echo "Last line of rc.local is exit 0, modifying line before last if we don't already have the auto-agent.py command in there..."

# 	grep -q -F 'sleep 10 && auto-agent.py &' /etc/rc.local || sudo sed -i -e '$i \sleep 10 && auto-agent.py &' /etc/rc.local 
# 	# sudo sed -i -e '$i \sleep 10 && auto-agent.py &' /etc/rc.local 
# fi
# cat /etc/rc.local
# sudo chmod +x /etc/rc.local




# echo "Setting up automatic sixaxis pairing upon USB connect via a simple udev rule and the standard sixpair binary..."
# sudo apt-get -y install libusb-dev joystick python-pygame
# wget http://www.pabr.org/sixlinux/sixpair.c
# gcc -o sixpair sixpair.c -lusb
# sudo cp -vf sixpair /usr/local/bin/
# sudo cp -vf /home/pi/primestationone/reference/etc/udev/rules.d/99-sixpair.rules /etc/udev/rules.d/

# popd



# #!/usr/bin/expect -f

# set timeout 360
# spawn installPs3RetroPieDriverCorrectly.sh
# expect "NOTE" { send "\r" }
# # spawn sudo /home/pi/RetroPie-Setup/retropie_packages.sh ps3controller pair gasia
# # expect "press the PS button to connect" { send "\r" }
# # spawn sudo /home/pi/RetroPie-Setup/retropie_packages.sh ps3controller pair gasia
# # expect "press the PS button to connect" { send "\r" }
