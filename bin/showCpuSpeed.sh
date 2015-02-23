#!/bin/bash

echo Minimum CPU frequency is $(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq)
echo Current CPU frequency is $(sudo cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq)
echo Maximum CPU frequency is $(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq)
echo CPU Governer is $(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor)
