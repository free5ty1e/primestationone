#!/bin/bash

echo "Mimicing Playstation 4 bluetooth behavior to automate the USB-connected PS4 controller pairing process..."

#!/bin/bash
/usr/local/bin/sixpairps4
bluetoothctl << EOF
scan on
pair $(hcitool dev | awk '/hci0/{print $2}')
trust $(hcitool dev | awk '/hci0/{print $2}')
connect $(hcitool dev | awk '/hci0/{print $2}')
EOF
