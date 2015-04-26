#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

echo Gonna pair the first discoverable bluetooth keyboard I find to this Primestation!  The pin will be 1234 for uber security, you will need to type this into the bluetooth keyboard when prompted to complete the pairing trust fall ritual required to pair...

echo Stopping sixad service since qtsixad DIRECTLY interferes with the standard bluetooth pairing process...
sudo service sixad stop

echo Scanning for your keyboard... ensure it is discoverable!  Typically done by holding the Pair or Connect button until something flashes blue.  This is the part of the script where your bluetooth keyboard should have something flashing blue on it...
echo Actually scanning twice so you can see the list of discoverable devices for troubleshooting purposes...
hcitool scan
firstBluetoothKeyboardAddress=$(hcitool scan | grep "Keyboard" | awk '{print $1}')

if [ -n "${firstBluetoothKeyboardAddress}" ]; then
    echo "firstBluetoothKeyboardAddress located is: $firstBluetoothKeyboardAddress"

    echo "Initiating pairing procedure between this Primestation and $firstBluetoothKeyboardAddress..."
    echo "You should see something like: RequestPinCode (/org/bluez/5856/hci0/dev_DC_2C_26_BB_EE_29)"
    echo "Enter PIN Code:"
    echo "...at which point, you should type in a PIN such as 1234 and press ENTER in this terminal window on the keyboard that is CURRENTLY WORKING here..."
    echo "...then, you should go to your BLUETOOTH KEYBOARD $firstBluetoothKeyboardAddress and do the exact same thing -- type in the same PIN 1234 and press ENTER.  Then you should see: "
    echo "Release"
    echo "...at which point, I should be able to take back over again to complete the process of making sure this autoconnects and is trusted whenever it is seen by the Primestation, even after a restart."
    sudo bluez-simple-agent hci0 "$firstBluetoothKeyboardAddress"

    echo "Hopefully all went well, I will now set up $firstBluetoothKeyboardAddress to be trusted and autoconnect whenever the Primestation sees it for uber convenience..."
    bluez-test-device trusted "$firstBluetoothKeyboardAddress" yes
    bluez-test-input connect "$firstBluetoothKeyboardAddress" yes

else
    echo No discoverable bluetooth keyboard could be found, cannot continue!
fi

echo Restarting sixad service as we are finished with standard bluetooth pairing operations...
sudo service sixad start
