#!/bin/bash
#CircuitStatic

# Non root user
if [[ "$USER" != 'root' ]]; then
    echo "Sorry, but you need to run this installer as root."
    exit
fi

# Non Debian system
if [[ ! -e /etc/debian_version ]]; then
    echo "You aren't running this installer on a Debian-based system."
    exit
fi

#Fix that networking
/usr/games/cowsay -f sodomized-sheep "Get rid of wicd crap"
sudo apt-get remove -y wicd 
/usr/games/cowsay -f mutilated "Go back to defaults for wireless and other networking"
sudo apt-get install --reinstall wpasupplicant network-manager
/usr/games/cowsay -f stimpy "Clean up"
sudo apt-get autoremove -y
sudo apt-get -y clean

/usr/games/cowsay -f vader "Ding! Fries are done."

