#!/bin/bash

if [ -z "$1" ]
then
    echo "No folder supplied, defaulting to current folder $(pwd)"
    currentFolder=""
else
    currentFolder="$1/"
fi

du -sch "$1*" .[!.]* | sort -rh
