#!/bin/bash

echo =====================> Obtaining latest Primestation One startup video..

pushd ~
rm -f video*
wget http://verilyshare.circuitstatic.com/video.mov
wget http://verilyshare.circuitstatic.com/video.3gp
popd

