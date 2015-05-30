#!/bin/bash
echo Loading PS3 Reicast Dreamcast Emulator joymap...
#loadmap ~/.joymaps/reicast.ps3.joymap.cfg
jscal --set-mappings 29,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,26,27,28,29,30,31,32,33,34,35,36,37,38,17,302,303,300,295,290,291,292,293,294,301,296,297,298,299,288,289,288,289,304 /dev/input/js0
