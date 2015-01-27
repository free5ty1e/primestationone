#!/bin/bash
#Simple stress test for system. If it survives this, it's probably stable.
#Free software, GPL2+

echo "Testing overclock stability..."

#Max out the CPU in the background (one core). Heats it up, loads the power-supply.
nice yes >/dev/null &

#Read the entire SD card, 2x. Tests RAM and I/O
for i in {1..2}; do echo reading: $i; sudo dd if=/dev/mmcblk0 of=/dev/null bs=4M; done

#Writes 512 MB test file,  5x.
#This needlessly wastes write cycles on my  SD card, screw that.
#for i in {1..5}; do echo writing: $i; dd if=/dev/zero of=deleteme.dat bs=1M count=512; sync; done

#Clean up
killall yes
rm deleteme.dat

#Print summary. Anything nasty will appear in dmesg.
echo -n "CPU freq: " ; cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq
echo -n "CPU temp: " ; cat /sys/class/thermal/thermal_zone0/temp
dmesg | tail

echo "Not crashed yet, probably stable."
