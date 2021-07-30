#!/bin/bash

#######################################  
 # Bash script for small project 1
 # Author: Rafli

## Check if running as root  
 if [ "$(id -u)" != "0" ]; then  
   echo "anda perlu menjalankan script ini sebagai root" 1>&2  
   exit 1  
 fi  

PS3='Pilih Opsi : '
install=("Webserver" "Database" "Download web file" "Uninstall" "Quit")
select fav in "${install[@]}"; do
    case $fav in

        "Webserver")
            echo "Installing $fav"
            # melakukan instalasi apache2 webserver
            echo "installing apache2 as $fav"
            apt-get install apache2 -y
            apt-get install php php-mysql -y
            service apache2 restart
            ;;

        "Database")
            echo "Installing $fav"
	        # melakukan instalasi Mysql database
            echo "installing mysql as $fav"
            apt-get install mysql-server -y
            ;;

        "Download web file")
            echo "download $fav"
            # proses instalasi landing-page ke dalam webserver
            wget -O landing-page.zip  https://github.com/sdcilsy/landing-page/archive/refs/heads/master.zip
            echo "extracting compressed file to destination directory"
            unzip landing-page.zip -d /var/www/html/

            # proses instalasi wordpress ke dalam webserver
            echo "download wordpress site"
            wget -O wordpress-id.tar.gz https://id.wordpress.org/latest-id_ID.tar.gz
            echo "extracting content to /var/www/html/"
            tar -xzvf wordpress-id.tar.gz -C /var/www/html/

            echo "configure wordpress"
            mv /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
            mysql -u root -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
            mysql -u root -e "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY '1234567890';"
            mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress . * TO 'wordpress'@'localhost';"
            mysql -u root -e "FLUSH PRIVILEGES;"

            #set database details with perl find and replace
            sed -i "s/database_name_here/wordpress/g" /var/www/html/wordpress/wp-config.php
            sed -i "s/username_here/root/g" /var/www/html/wordpress/wp-config.php
            sed -i "s/password_here/password/g" /var/www/html/wordpress/wp-config.php

            #membuat folder uploads dan set permissions
            mkdir /var/www/html/wp-content/uploads
            chmod 777 /var/www/html/wp-content/uploads

            echo "download social media site"
            wget -O social_media.zip https://github.com/sdcilsy/sosial-media/archive/refs/heads/master.zip

            echo "extracting social media site to /var/www/html"
            unzip social_media.zip -d /var/www/html/

            echo "configuring database"
            echo "creating database for social media site"
            mysql -u root -e "create database dbsosmed"
            echo "creating dbusername and dbpassword"
            mysql -u root -e "CREATE USER 'devopscilsy'@'localhost' IDENTIFIED BY '1234567890';"
            mysql -u root -e "GRANT ALL PRIVILEGES ON dbsosmed . * TO 'devopscilsy'@'localhost';"
            mysql -u root -e "FLUSH PRIVILEGES;"
            mysql -u root dbsosmed < /var/www/html/sosial-media-master/dump.sql
            echo "done"
            ;;
        "Uninstall")
            apt remove apache2* -y
            apt remove mysql-server* -y
            apt remove php php-mysql -y
            apt auto-clean
            rm -rf /var/www/*
	    break
            ;;
	"Quit")
	    echo "User requested exit"
	    exit
	    ;;
        *) echo "invalid option $REPLY";;
    esac
done