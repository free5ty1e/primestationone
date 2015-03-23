#!/bin/bash

message="Scraping all systems..."
echo "$message"
cowsay -f flaming-sheep "$message"

echo Installing python imaging library PIL for boxart resizing operations...
sudo apt-get -y install python-imaging"

pushd ~

echo Cleaning out old manual scraper...
rm -rf ES-scraper

echo Cloning new manual scraper...
git clone https://github.com/thadmiller/ES-scraper.git

cd ES-scraper

echo Scraping arcade...
#Remove -l to choose each rom manually
python scraper.py -pisize -l -rompath /home/pi/RetroPie/roms/mame -name MAMElrmame4all -platform arcade -ext ".zip .ZIP"

echo Scraping nes...
python scraper.py -pisize -l -rompath /home/pi/RetroPie/roms/nes -name nes -platform nes -ext ".zip .ZIP"

echo Complete, hopefully!

popd
