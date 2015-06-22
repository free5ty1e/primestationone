#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

echo Gonna pair the first discoverable bluetooth mouse I find to this Primestation!

echo Stopping sixad service since qtsixad DIRECTLY interferes with the standard bluetooth pairing process...
sudo service sixad stop

echo Ensuring bluetoothd is executable!
sudo chmod +x /usr/sbin/bluetoothd

echo Restarting the bluetooth service now that sixad has stopped
sudo /etc/init.d/bluetooth restart

echo Scanning for your mouse... ensure it is discoverable!  Typically done by holding the Pair or Connect button until something flashes blue.  This is the part of the script where your bluetooth mouse should have something flashing blue on it...
echo Actually scanning twice so you can see the list of discoverable devices for troubleshooting purposes...
hcitool scan
firstBluetoothMouseAddress=$(hcitool scan | grep "Mouse" | awk '{print $1}')

if [ -n "${firstBluetoothMouseAddress}" ]; then
    echo "firstBluetoothMouseAddress located is: $firstBluetoothMouseAddress"

    echo "Initiating pairing procedure between this Primestation and $firstBluetoothMouseAddress..."
    sudo bluez-simple-agent hci0 "$firstBluetoothMouseAddress"

    echo "Hopefully all went well, I will now set up $firstBluetoothMouseAddress to be trusted and autoconnect whenever the Primestation sees it for uber convenience..."
    bluez-test-device trusted "$firstBluetoothMouseAddress" yes
    bluez-test-input connect "$firstBluetoothMouseAddress" yes

else
    echo No discoverable bluetooth mouse could be found, cannot continue!
fi

echo Restarting sixad service as we are finished with standard bluetooth pairing operations...
sudo service sixad start
