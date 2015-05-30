#!/bin/bash
echo Loading PS3 Reicast Dreamcast Emulator joymap...
#loadmap ~/.joymaps/reicast.ps3.joymap.cfg
jscal --set-mappings 27,0,1,2,5,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,19,302,303,300,297,292,293,294,295,296,301,298,299,290,291,288,289,704,705,706 /dev/input/js0
