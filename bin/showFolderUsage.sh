#!/bin/bash

if [ -z "$1" ]
then
    echo "No folder supplied, defaulting to current folder $(pwd)"
    currentFolder="$(pwd)"
else
    currentFolder="$1"
fi

du -sch "$currentFolder/*" .[!.]* | sort -rh
