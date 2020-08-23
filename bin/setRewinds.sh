#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

fancy_console_message "Enabling rewind functionality on basic emulators..."
rewindAtari2600Enable.sh
rewindGenesisEnable.sh
rewindNesEnable.sh
rewindSnesEnable.sh
rewindTg16Enable.sh
rewindGamegearEnable.sh
rewindGameboyEnable.sh
rewindGameboyColorEnable.sh
rewindMastersystemEnable.sh
rewindLynxEnable.sh
rewindGlobalLongerCoarseBuffer.sh

