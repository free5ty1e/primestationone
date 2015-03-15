#!/bin/bash
params="$1"
if [[ "$params" =~ \.sh$ ]]; then
    params="-c \"MOUNT C /home/pi/RetroPie/roms/pc\""
else
    params+=" -exit"
fi
/opt/retropie/supplementary/runcommand/runcommand.sh 0 "/opt/retropie/emulators/dosbox/bin/dosbox $params" "dosbox"
