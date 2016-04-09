#!/bin/bash

echo "Installing Go language and ANSIze image to ANSI converter..."

installPackageUniversal.sh golang

mkdir "$HOME/gocode"

if [ -f "$HOME/.bashrc" ]; then
    echo ".bashrc found, modifying..."
    echo "export GOPATH=$HOME/gocode" >> "$HOME/.bashrc"
else
    echo "no .bashrc, guessing .bash_profile, modifying..."
    echo "export GOPATH=$HOME/gocode" >> "$HOME/.bash_profile"
fi

export "GOPATH=$HOME/gocode"
go get github.com/nfnt/resize
go get github.com/jhchen/ansize

sudo cp "$GOPATH/bin/ansize" /usr/local/bin/
ansize
