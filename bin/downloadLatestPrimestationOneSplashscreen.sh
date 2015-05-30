#!/bin/bash

echo Obtaining latest Primestation One splashscreen image...

pushd ~
cp ~/splashscreen.png ~/backup_splashscreen.png
rm -f splashscreen*

echo Downloading base splashscreen from imgur...
wget --output-document=splashscreen.png http://i.imgur.com/17aeRJl.png

#If that didn't work, grab the backup splashscreen from verilyshare:
if [ ! -f splashscreen.png ]; then
    echo "Splashscreen download from imgur failed, falling back to verilyshare backup splashscreen!"
    wget http://verilyshare.circuitstatic.com/splashscreen.png
fi

#If that didn't work, grab the previous version that was here before, maybe internet is down!:
if [ ! -f splashscreen.png ]; then
    echo "Splashscreen download from imgur failed, falling back to previous version that was here before!"
    cp ~/backup_splashscreen.png ~/splashscreen.png
fi

rm ~/backup_splashscreen.png

popd
