#!/bin/bash
pushd /opt/retropie/emulators/reicast
echo Reading the entire Reicast emulator into memory to execute from there...
sudo mkdir tmpfs
sudo mount -o size=150M -t tmpfs none tmpfs/
sudo cp -v * tmpfs/
cd tmpfs
sudo aoss ./reicast.elf -config config:homedir=/home/pi -config config:image="$1"
cd ..
echo Ensuring any freshly-created VMUs are owned by pi and not root...
sudo chown -R pi:pi /home/pi/.reicast
echo Freeing up memory...
sudo umount /opt/retropie/emulators/reicast/tmpfs
sudo rm -rf tmpfs
popd
