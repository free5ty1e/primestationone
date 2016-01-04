#!/bin/bash

cowsay -f hellokitty Installing MPEG video recording capability...
echo Installing MPEG video recording capability...

pushd ~

echo "Procedure developed using below site as reference:"
echo "http://owenashurst.com/?p=242"
sudo apt-get remove --purge -y libmp3lame-dev libtool libssl-dev libaacplus-* libx264 libvpx librtmp ffmpeg
sudo apt-get install -y libmp3lame-dev autoconf libtool checkinstall libssl-dev libavcodec-dev

mkdir src
cd src

echo "Downloading & Compiling LibaacPlus..."
wget http://tipok.org.ua/downloads/media/aacplus/libaacplus/libaacplus-2.0.2.tar.gz
tar -xzf libaacplus-2.0.2.tar.gz
cd libaacplus-2.0.2
./autogen.sh --with-parameter-expansion-string-replace-capable-shell=/bin/bash --host=arm-unknown-linux-gnueabi --enable-static
make
sudo make install

echo "Downloading & Compiling Libx264..."
cd /home/pi/src
git clone git://git.videolan.org/x264
cd x264
./configure --host=arm-unknown-linux-gnueabi --enable-static --disable-opencl
make
sudo make install

echo "Downloading & Compiling LibVPX..."
cd /home/pi/src
git clone https://chromium.googlesource.com/webm/libvpx
cd libvpx
./configure
make
sudo checkinstall --pkgname=libvpx --pkgversion="1:$(date +%Y%m%d%H%M)-git" --backup=no     --deldoc=yes --fstrans=no --default

echo "Downloading & Compiling LibRTMP..."
cd /home/pi/src
git clone git://git.ffmpeg.org/rtmpdump
cd rtmpdump
make SYS=posix
sudo checkinstall --pkgname=rtmpdump --pkgversion="2:$(date +%Y%m%d%H%M)-git" --backup=no --deldoc=yes --fstrans=no --default

echo "Updating system package list..."
sudo ldconfig

echo "Downloading & Compiling FFMPEG (Latest Version)..."
cd /home/pi/src
git clone --depth 1 git://git.videolan.org/ffmpeg
cd ffmpeg
echo "disabled: --enable-libaacplus"
./configure --prefix=/opt/ffmpeg --arch=armel --target-os=linux --enable-gpl --enable-libx264 --enable-nonfree --enable-librtmp --enable-libmp3lame
make
sudo make install

installRetroArchWithMpegRecordingEnabled.sh

echo "Please reboot, then type ffmpeg and ensure you get some sort of sensible output to confirm installation!"

popd
pause
