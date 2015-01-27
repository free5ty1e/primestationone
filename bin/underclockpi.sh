#!/bin/bash

if [ $# -eq 0 ];
then
echo "No arguments supplied, will use default frequency of 300MHz"
speedToClockPi=300
else
echo "Using supplied speed of $1MHz for our processor"
speedToClockPi=$1
fi
echo "Setting Pi to Powersave governor, with your provided speed of $speedToClockPi"
echo "$speedToClockPi000" | sudo tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq > /dev/null
echo "powersave" | sudo tee /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor > /dev/null
