#!/bin/bash
pushd "/opt/retropie/emulators/rpix86"
./rpix86 -a0 -f2 "$1"
popd
