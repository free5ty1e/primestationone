#!/bin/bash

echo =====================> Obtaining latest Primestation One startup video..

pushd ~
rm -f video.mp4
wget http://verilyshare.circuitstatic.com/video.mp4
popd

