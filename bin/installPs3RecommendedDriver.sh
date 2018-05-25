#!/bin/bash

# Install bluez5 auto pairing capabilities:
sudo sed -i -- 's/#deb-src/deb-src/g' /etc/apt/sources.list && sudo sed -i -- 's/# deb-src/deb-src/g' /etc/apt/sources.list
sudo apt-get update
sudo apt-get -y install libbluetooth-dev bluez-tools
sudo -H pip install wheel
sudo -H pip install pybluez
wget https://raw.githubusercontent.com/pauloborges/bluez/master/test/bluezutils.py
sudo cp -vf bluezutils.py /usr/local/bin/

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

sudo cp -vf /home/pi/primestationone/reference/etc/systemd/system/autobtpair.service /etc/systemd/system/
sudo systemctl enable autobtpair
sudo systemctl enable autobtpair.service




# #!/usr/bin/expect -f

# set timeout 360
# spawn installPs3RetroPieDriverCorrectly.sh
# expect "NOTE" { send "\r" }
# # spawn sudo /home/pi/RetroPie-Setup/retropie_packages.sh ps3controller pair gasia
# # expect "press the PS button to connect" { send "\r" }
# # spawn sudo /home/pi/RetroPie-Setup/retropie_packages.sh ps3controller pair gasia
# # expect "press the PS button to connect" { send "\r" }
