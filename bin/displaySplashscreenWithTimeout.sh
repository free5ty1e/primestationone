#!/bin/bash
echo "Displaying using required provided timeout $1, optional filename $2..."
if [ -z "$2" ]
then
    imageFile="/home/pi/splashscreenwithcontrolsandversion.png"
else
    imageFile="$2"
fi

sudo fbi -T 7 -t $1 -a "$imageFile"
