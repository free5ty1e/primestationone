#!/bin/bash
source "/home/pi/primestationone/reference/lib/primestation_bash_functions.sh"

fancy_console_message "Enabling rewind functionality on basic emulators..."
rewindIntellivisionEnable.sh
rewindAtari800Enable.sh
rewindAtari2600Enable.sh
rewindAtari7800Enable.sh
rewindLynxEnable.sh
rewindGenesisEnable.sh
rewindNesEnable.sh
rewindSnesEnable.sh
rewindTg16Enable.sh
rewindGamegearEnable.sh
rewindGameboyEnable.sh
rewindGameboyColorEnable.sh
rewindMastersystemEnable.sh

rewindGlobalLongerCoarseBuffer.sh
