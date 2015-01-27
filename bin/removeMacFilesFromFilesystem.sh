#!/bin/bash
sudo find / -name \._* -type f -print0 | xargs -0 sudo rm -f
