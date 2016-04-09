#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"
pushd ~
wget https://pbs.twimg.com/profile_images/2221189782/beavis_butthead.jpg
ansize beavis_butthead.jpg beavis_butthead.ansi 160
ansize splashscreen.png splashscreen.ansi 160
popd
