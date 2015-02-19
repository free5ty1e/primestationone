#!/bin/bash
echo "Finding each file matching $1 in current folder and zipping individually"
find . -name "*$1*" -print -exec zip '{}'.zip '{}' \;
