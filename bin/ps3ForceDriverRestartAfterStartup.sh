#!/bin/bash

source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

#addLineToEndOfFileIfNOtExist "sudo /etc/init.d/sixad restart" "$HOME/.bashrc"
sudo sed -i -e '$ i\sudo /etc/init.d/sixad restart' /etc/rc.local
