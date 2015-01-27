#!/bin/bash

sudo service apache2 stop
sudo service webmin stop
sudo service tor stop
sudo service cupsd stop
mysqld



#Stop services permanently
sudo update-rc.d -f webmin remove


#Start services permanently again later:

