#!/bin/sh

jawaban_webserver = ("Y" "y")
read -p "apakah anda ingin menginstall webserver? (Y/n)" install_apache2;
if [$jawaban_webserver == $install_apache2]
then
    echo "melakukan installasi webserver"
    sudo apt-get install apache2
    read -p "apakah anda ingin menginstall database? (Y/n)"
else

    
fi