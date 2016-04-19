#!/bin/bash

cowsay -f hellokitty "Fixing wifi..."
echo "Fixing wifi..."

pushd ~


#edit sshd_config to have the following line
IPQoS cs0 cs0

echo "Fixing ntp..."
/sbin/iptables -t mangle -I POSTROUTING 1 -o wlan0 -p udp --dport 123 -j TOS --set-tos 0x00

popd
