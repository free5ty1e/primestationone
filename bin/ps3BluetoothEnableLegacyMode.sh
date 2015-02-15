#!/bin/bash
sudo cp ~/primestationone/reference/etc/default/sixad.legacy /etc/default/sixad
sudo update-rc.d sixad defaults
