#!/bin/bash

cowsay -f calvin Installing bluetooth MAC address changer bdaddr...

pushd ~

cp -rv primestationone/reference/lib/bdaddr .
cd bdaddr
make
sudo cp bdaddr /usr/local/bin/
popd
