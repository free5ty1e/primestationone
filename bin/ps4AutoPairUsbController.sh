#!/bin/bash

echo "Automating the pairing process for a Sony DualShock 4 controller..."
echo "First running sixpairps4 to set the bt master mac address via USB"
/usr/local/bin/sixpairps4

# Set variables
CONTROLLER_NAME="Wireless Controller"
SCAN_TIMEOUT=30

# Start bluetoothctl in a controlled session
echo -e "Starting a controlled bluetoothctl session...\n"

bluetoothctl <<EOF
agent on
default-agent
scan on
EOF

echo -e "Scan started. Please unplug the controller and press the PS button.\n"
sleep $SCAN_TIMEOUT

# Find the controller's MAC address
MAC=$(bluetoothctl devices | grep "$CONTROLLER_NAME" | awk '{print $2}')
if [[ "$MAC" == "" ]]; then
  echo "Failed to detect the controller. Ensure the controller is in pairing mode and try again."
  bluetoothctl scan off
  exit 1
fi

echo "Controller detected with MAC: $MAC"

# Pair, trust, and connect the controller
bluetoothctl <<EOF
scan off
pair $MAC
trust $MAC
connect $MAC
quit
EOF

# Verify if the controller is connected
if bluetoothctl info "$MAC" | grep -q "Connected: yes"; then
  echo "Controller successfully paired and connected!"
else
  echo "Controller pairing or connection failed. Please check the logs."
fi
