#!/bin/bash

cowsay -f moofasa Installing system status page auto updater cronjob...
PAGE_UPDATER_COMMAND="sudo update_system_info_page.sh"
#Timing = 0 0 * * * = every day @ 12:00am midnight
CRONTAB_TIMING_HEADER="0 0 * * *"
crontab -l | grep -q "$PAGE_UPDATER_COMMAND" && echo 'crontab entry exists, skipping...' || (crontab -l 2>/dev/null; echo "$CRONTAB_TIMING_HEADER $PAGE_UPDATER_COMMAND") | crontab -
echo Generating and updating the apache sys info page...
$PAGE_UPDATER_COMMAND
