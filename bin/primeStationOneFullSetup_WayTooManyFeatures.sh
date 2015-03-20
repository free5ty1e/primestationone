#!/bin/bash

function pause()
{
    read -p "$*"
}

echo PrimeStationOne Setup script - to be run on the PI after copying the PrimeStationOne files on top of a functional RetroPie image.
echo Run the primeStationOneCopyFilesToPi script first from the installing computer after setting up an SSH key for passwordless SCP transfers... or just clone the github repo directly onto the Pi, easier...

echo Making sure things are up to date...
sudo apt-get -y update
sudo apt-get -y check
sudo apt-get -y dist-upgrade
echo =========Now you should probably choose your time zone.  Pacific New is correct for Oregon by the way...
sudo dpkg-reconfigure tzdata
sudo apt-get -y upgrade

echo Updating Pi firmware!  If this happens, you probably have to reboot...
sudo rpi-update

~/primestationone/bin/installAptPackages

cowsay Installing and updating RetroPie-Setup...
echo Now getting the latest RetroPie-Setup script.
cd ~
git clone --depth=0 git://github.com/petrockblog/RetroPie-Setup.git
cd ~/RetroPie-Setup
git pull
chmod +x retropie_packages.sh
chmod +x retropie_setup.sh
cd ~

cowsay -f vader Installing PrimeStationOne...
echo Beginning install process of custom stuffs and installation of scripts and executables to their correct locations
~/primestationone/bin/quickUpdatePrimestationOneFiles.sh

echo Installing corrected blank gamelist.xml files...
installBlankGamelists

echo Building hello_pi example and utility projects
pushd /opt/vc/src/hello_pi
sudo ./rebuild.sh
popd

echo Updating PrimestationOne Specific RetroPie packages
updatePrimestationSpecificRetroPiePackages

#checkinstall -y libusb-dev libbluetooth-dev joystick

#cowsay Installing PS3 Pairing
#echo Installing sixpair to /usr/bin
#wget http://www.pabr.org/sixlinux/sixpair.c
#gcc -o sixpair sixpair.c -lusb
#sudo cp ./sixpair /usr/bin
#cowsay -f calvin Connect your PS3 controller to the Pi with a USB cable, and then press Enter to continue...
#pause 'Please ensure your PS3 controller is connected to the Pi with a USB cable, then press Enter to continue...'
#sudo sixpair

installLinuxJoystickMapper.sh

installPs3BluetoothDaemon.sh

cowsay Installing mySQL stuffs...
echo Installing mySQL server and client, which may prompt for passwords.  I recommend you set the passwords match the Pi user password, which is raspberry
sudo apt-get install -y mysql-server mysql-client

cowsay -f vader Installing LAMP server and Webmin...
sudo groupadd -f -g33 www-data
sudo apt-get -y update
sudo apt-get -y install apache2 php5 libapache2-mod-php5
sudo apt-get -y install mysql-server mysql-client php5-mysql
sudo apt-get -y install phpmyadmin
sudo apt-get -y install perl libnet-ssleay-perl openssl libauthen-pam-perl libpam-runtime libio-pty-perl apt-show-versions python libapt-pkg-perl
wget http://downloads.sourceforge.net/project/webadmin/webmin/1.720/webmin_1.720_all.deb
sudo dpkg --install webmin_1.720_all.deb

cowsay Launching retropie setup menu...
sudo ~/RetroPie-Setup/retropie_setup.sh




