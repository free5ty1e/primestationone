#!/bin/bash

OUT=/home/pi/timelapse
echo "Creating timelapse from $OUT to $OUT/timelapse.mp4 ...."
# avconv -r 5 -i "$OUT/*.jpg" -vcodec libx264 -r 30 "$OUT/timelapse.mp4"

cat "$OUT/*.jpg" | avconv -r 30 -f image2pipe -codec:v mjpeg -i - -pix_fmt yuvj420p -r 30 -c:v libx264 -y "$OUT/timelapse.mp4"
# -vf scale=480:300

echo "Done!"
