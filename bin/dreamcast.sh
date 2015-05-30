#!/bin/bash

pushd /opt/retropie/emulators/reicast
sudo mkdir tmpfs
sudo mount -t tmpfs none tmpfs/
sudo cp -a * tmpfs/
cd tmpfs
./reicast.sh "$1"
cd ..
echo Updating VMU units...
sudo cp tmpfs/*.bin .
sudo unmount tmpfs
sudo rm -rf tmpfs
popd


