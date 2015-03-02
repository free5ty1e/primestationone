#!/bin/bash

echo =====================> Obtaining latest Primestation One splashscreen image...

pushd ~
rm -f splashscreen*
wget http://verilyshare.circuitstatic.com/splashscreen.png

#If that didn't work, grab the backup splashscreen from imgur:
if [ ! -f /tmp/foo.txt ]; then
    echo "Splashscreen download from verilyshare failed, falling back to imgur backup splashscreen!"
    wget --output-document=splashscreen.png http://i.imgur.com/UnMdAZX.png
fi

popd
