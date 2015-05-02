#!/bin/bash
echo "Displaying using required provided timeout $1..."
sudo fbi -T 7 -t $1 -a /home/pi/splashscreenwithcontrolsandversion.png
