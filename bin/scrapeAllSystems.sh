#!/bin/bash

message="Scraping all systems..."
echo "$message"
cowsay -f flaming-sheep "$message"

python scraper.py -pisize -rompath /home/pi/RetroPie/roms/mame -name MAMElrmame4all -platform arcade -ext ".zip .ZIP"