#!/bin/bash

echo =====================> Obtaining latest Primestation One splashscreen image...

pushd ~
rm -f splashscreen*
wget http://verilyshare.circuitstatic.com/video.mp4
popd

