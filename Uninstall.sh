#!/bin/sh
sudo mysql -u root -p -e "drop database sosial_media"
sudo apt  remove apache2* -y
sudo apt remove mysql-server* -y
sudo apt purge apache2*
sudo apt purge mysql-server*
sudo apt autoclean