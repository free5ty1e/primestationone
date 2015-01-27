#!/bin/bash

cowsay -f unipony-smaller Installing onReboot PrimeStation One auto quickupdater cronjob...
CRON_COMMAND="quickUpdatePrimestationOneFiles.sh"
CRONTAB_TIMING_HEADER="@reboot"
crontab -l | grep -q "$CRON_COMMAND" && echo 'crontab entry exists, skipping...' || (crontab -l 2>/dev/null; echo "$CRONTAB_TIMING_HEADER $CRON_COMMAND") | crontab -

