#!/bin/bash

echo Building hello_pi example and utility projects, because why not...
echo Note this might require more video memory than we usually require...
pushd /opt/vc/src/hello_pi/hello_teapot
./hello_teapot.bin
popd
