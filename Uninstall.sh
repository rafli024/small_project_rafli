#!/bin/sh

sudo apt-get remove apache2* -y
sudo apt remove mysql-server* -y
sudo apt purge apache2*
sudo apt purge mysql-server*
sudo apt autoclean