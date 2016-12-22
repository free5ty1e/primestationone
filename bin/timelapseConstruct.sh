#!/bin/bash

if [ -z "$*" ] ; then 
	TIMELAPSEPHOTOS=/home/pi/timelapse
	echo "No timelapse photo location provided, defaulting to $TIMELAPSEPHOTOS"
else
	TIMELAPSEPHOTOS="$1"
	echo "Timelapse photo location provided: $TIMELAPSEPHOTOS"
fi

if [ -z "$2" ] ; then 
	OUT="$TIMELAPSEPHOTOS/timelapse.mp4"
	echo "No timelapse video output location provided, defaulting to $OUT"
else
	OUT="$2"
	echo "Timelapse video output location provided: $OUT"
fi

echo "Creating timelapse from JPGs in $TIMELAPSEPHOTOS to $TIMELAPSEPHOTOS/timelapse.mp4 ...."

cat "$TIMELAPSEPHOTOS/*.jpg" | avconv -r 30 -f image2pipe -codec:v mjpeg -i - -pix_fmt yuvj420p -r 30 -c:v libx264 -y "$OUT"

echo "Done (as far as you know)!"
