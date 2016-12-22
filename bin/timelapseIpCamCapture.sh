#!/bin/bash

if [ -z "$*" ] ; then 
	SECONDSPERFRAME=5
	echo "No delay provided, defaulting to $SECONDSPERFRAME seconds between frames"
else
	SECONDSPERFRAME=$1
	echo "Delay provided: $SECONDSPERFRAME seconds between frames"
fi

if [ -z "$2" ] ; then
	URL="http://192.168.1.18:8080/shot.jpg"
	echo "No URL provided, defaulting to the one at my house: $SNAP"
else
	URL="$2"
	echo "URL provided: $URL"
fi

if [ -z "$3" ] ; then
	OUT=/home/pi/timelapse
	echo "No output location provided, defaulting to $OUT"
else
	OUT="$3"
	echo "Output location provided: $OUT"
fi

# NOTE: replace user, password and camera-address with the actual values
# SNAP="wget -nv http://user:password@camera-address/axis-cgi/jpg/image.cgi"
SNAP="wget -nv $URL"
mkdir $OUT
echo "Now capturing $SNAP to $OUT, press CTRL-C to stop capturing!" 
while true; do
		echo "Capturing $OUT/$( date +%s ).jpg ... "
        $SNAP -O $OUT/$( date +%s ).jpg
        echo "Waiting $SECONDSPERFRAME before next capture..."
        sleep $SECONDSPERFRAME
done
