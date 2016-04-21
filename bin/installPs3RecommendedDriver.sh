#!/usr/bin/expect -f
set timeout 360
spawn installPs3RetroPieDriverCorrectly.sh
expect "press the PS button to connect" { send "\r" }
