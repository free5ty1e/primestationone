#!/usr/bin/expect -f
set timeout 360
spawn installPs3RetroPieDriverCorrectly.sh
expect "press the PS button to connect" { send "\r" }
spawn sudo /home/pi/RetroPie-Setup/retropie_packages.sh ps3controller pair gasia
expect "press the PS button to connect" { send "\r" }
spawn sudo /home/pi/RetroPie-Setup/retropie_packages.sh ps3controller pair gasia
expect "press the PS button to connect" { send "\r" }
