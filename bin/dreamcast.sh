#!/bin/bash

pushd /opt/retropie/emulators/reicast

echo Reading the entire Reicast emulator into memory to execute from there...
sudo mkdir tmpfs
sudo mount -o size=450M -t tmpfs none tmpfs/
sudo cp -v * tmpfs/

#echo Reading your user VMUs into memory...
#sudo cp /home/pi/.dcvmu/*.bin .

cd tmpfs
sudo aoss ./reicast.elf -config config:homedir=/home/pi -config config:image="$1"
cd ..

#echo Updating VMU units from memory...
#sudo cp tmpfs/*.bin .
#mkdir /home/pi/.dcvmu
#cp *.bin /home/pi/.dcvmu/

echo Freeing up memory...
sudo umount /opt/retropie/emulators/reicast/tmpfs
sudo rm -rf tmpfs

popd
