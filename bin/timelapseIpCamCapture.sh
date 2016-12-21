#!/bin/bash

# NOTE: replace user, password and camera-address with the actual values
# SNAP="wget -nv http://user:password@camera-address/axis-cgi/jpg/image.cgi"
SNAP="wget -nv http://192.168.1.18:8080/shot.jpg"
OUT=/home/pi/timelapse
SECONDSPERFRAME=5
mkdir $OUT
echo "Now capturing $SNAP to $OUT, press CTRL-C to stop capturing!" 
while true; do
		echo "Capturing $OUT/$( date +%s ).jpg ... "
        $SNAP -O $OUT/$( date +%s ).jpg
        echo "Waiting $SECONDSPERFRAME before next capture..."
        sleep $SECONDSPERFRAME
done


# # Timelapse controller for USB webcam

# DIR=frames

# #counter for filename
# n=1
# #counter for files saved
# x=1
# #number of screenshots to take
# num=10000
# #interval at which screenshots get taken in seconds
# interval=5
# while [ $x -le $num ]; do

# filename=$(printf "%05d.jpg" "$n")
# let n=n+1

# #Capture image
# fswebcam -d /dev/video0 -S 5 -D 1 -r 1280x720 --jpeg 95 --no-banner --save $DIR/$filename
# #add timestamp with imagemagick
# convert $DIR/$filename -pointsize 30 -fill white -stroke black -gravity southeast -annotate +4+0 "$(date +"%D %r")" $DIR/$filename

# x=$(( $x + 1 ))

# sleep $interval;

# done;
