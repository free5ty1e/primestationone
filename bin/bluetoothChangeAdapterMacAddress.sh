#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

#TODO: Need to add parameter for default value to display in inputbox to have existing bluetooth mac address prepopulated to make this actually user friendly

fancy_console_message "Preparing to retrieve and then allow you to change your bluetooth adapter's MAC address..." "head-in"
installBluetoothMacAddressChanger.sh
firstBluetoothAdapterMacAddress=$(bdaddr | grep address | awk '{print $3}')

isPassword=0
ask_for_user_input_and_store_result "LOGIN TO MEGA.CO.NZ" "EMAIL: For existing users of mega.co.nz" "Please enter your email address to login to Mega.co.nz (one that already has an account with them)" $isPassword 8 60 "$firstBluetoothAdapterMacAddress"
newDesiredBluetoothAdapterMacAddress="$RESULT"

fancy_console_message "Writing desired new bluetooth adapter MAC address $newDesiredBluetoothAdapterMacAddress over old address $firstBluetoothAdapterMacAddress..." "gnu"
bdaddr -i hci0 "$newDesiredBluetoothAdapterMacAddress"

newFirstBluetoothAdapterMacAddress=$(bdaddr | grep address | awk '{print $3}')
fancy_console_message "newFirstBluetoothAdapterMacAddress is $newFirstBluetoothAdapterMacAddress!  Hopefully that was successful in setting your desired address $newDesiredBluetoothAdapterMacAddress.  Hopefully, someday someone will enhance this script to check for success / failure, but that day is not today.  --Prime"
