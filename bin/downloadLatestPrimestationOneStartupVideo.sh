#!/bin/bash

echo Obtaining latest Primestation One startup video..

pushd ~
rm -f video*
wget http://verilyshare.circuitstatic.com/video00.mov
#wget http://verilyshare.circuitstatic.com/video01.mov
popd
