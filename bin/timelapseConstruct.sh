#!/bin/bash

OUT=/home/pi/timelapse
echo "Creating timelapse from $OUT to $OUT/timelapse.mp4 ...."
avconv -r 5 -i "$OUT/*.jpg" -vcodec libx264 -r 30 "$OUT/timelapse.mp4"
echo "Done!"
