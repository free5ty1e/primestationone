#!/bin/bash

echo =====================> Obtaining latest Primestation One startup video..

pushd ~
rm -f splashscreen*
wget http://verilyshare.circuitstatic.com/video.mp4
popd

