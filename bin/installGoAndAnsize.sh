#!/bin/bash

echo "Installing Go language and ANSIze image to ANSI converter..."
sudo apt-get install -y golang
mkdir /home/pi/gocode
echo 'export GOPATH=/home/pi/gocode' >> /home/pi/.bashrc
go get github.com/nfnt/resize
go get github.com/jhchen/ansize
sudo cp "$GOPATH/bin/ansize" /usr/local/bin/
ansize
