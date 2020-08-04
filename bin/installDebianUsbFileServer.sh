#!/bin/bash

echo "Installing free5ty1e's (hey, that's me!) Debian USB File Server repository"

sudo apt-get update
# sudo apt-get -y install git
pushd ~
rm -rf debianusbfileserve
git clone https://github.com/free5ty1e/debianusbfileserver.git
debianusbfileserver/scripts/installfiles.sh
popd
finishinstall.sh
