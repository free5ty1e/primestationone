#!/bin/bash

message="Scraping all systems..."
echo "$message"
cowsay -f flaming-sheep "$message"

echo Installing python imaging library PIL for boxart resizing operations...
sudo apt-get -y install python-imaging

pushd ~

mkdir scrapers
cd scrapers

crcScraper="crc-scraper"
filenameScraper="filename-scraper"

echo Cleaning out old manual filename scraper...
rm -rf ES-scraper
rm -rf "$crcScraper"
rm -rf "$filenameScraper"

echo Cloning new manual filename based scraper...
git clone https://github.com/thadmiller/ES-scraper.git "$filenameScraper"

echo Cloning new manual crc based scraper...
git clone https://github.com/chugcup/ES-scraper.git "$crcScraper"


#Remove -l to choose each rom manually

#echo "Scraping arcade via $crcScraper"
#pushd "$crcScraper"
#python "$crcScraper/scraper.py" -pisize -l -crc -rompath /home/pi/RetroPie/roms/mame -name MAMElrmame4all -platform arcade -ext ".zip .ZIP"
#popd

echo "Scraping arcade via $filenameScraper"
pushd "$filenameScraper"
python "$filenameScraper/scraper.py" -pisize -l -rompath /home/pi/RetroPie/roms/mame -name MAMElrmame4all -platform arcade -ext ".zip .ZIP"
popd

#echo Scraping nes via crc...
#pushd "$crcScraper"
#python "$crcScraper/scraper.py" -pisize -l -crc -rompath /home/pi/RetroPie/roms/nes -name nes -platform nes -ext ".zip .ZIP"
#popd

echo Scraping nes via filename...
pushd "$filenameScraper"
python "$filenameScraper/scraper.py" -pisize -l -rompath /home/pi/RetroPie/roms/nes -name nes -platform nes -ext ".zip .ZIP"
popd

echo Complete, hopefully!
popd
