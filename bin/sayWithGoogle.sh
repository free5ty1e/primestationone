#!/bin/bash
#Prerequisites = alsa-utils mplayer
#sudo apt-get install -y alsa-utils mplayer
#ensure setting in mplayer.conf is correct:
#sudo echo nolirc=yes > /etc/mplayer/mplayer.conf
say() { local IFS=+;/usr/bin/mplayer -ao alsa -really-quiet -noconsolecontrols "http://translate.google.com/translate_tts?tl=en&q=$*"; }
say $*
