#!/bin/bash
bluetoothctl -a << EOF
power on
trust \t
pair \t
connect \t
quit
EOF
