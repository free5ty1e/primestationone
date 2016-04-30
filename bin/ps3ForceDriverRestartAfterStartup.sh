#!/bin/bash

source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

addLineToEndOfFileIfNOtExist "sudo /etc/init.d/sixad restart" .bashrc
