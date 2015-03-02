#!/bin/bash

echo =====================> Obtaining latest Primestation One splashscreen image...

pushd ~
cp ~/splashscreen.png ~/backup_splashscreen.png
rm -f splashscreen*
wget http://verilyshare.circuitstatic.com/splashscreen.png

#If that didn't work, grab the backup splashscreen from imgur:
if [ ! -f splashscreen.png ]; then
    echo "Splashscreen download from verilyshare failed, falling back to imgur backup splashscreen!"
    wget --output-document=splashscreen.png http://i.imgur.com/UnMdAZX.png
fi

#If that didn't work, grab the previous version that was here before, maybe internet is down!:
if [ ! -f splashscreen.png ]; then
    echo "Splashscreen download from imgur failed, falling back to previous version that was here before!"
    cp ~/backup_splashscreen.png ~/splashscreen.png
fi

rm ~/backup_splashscreen.png

popd
