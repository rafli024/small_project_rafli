#!/bin/bash

#######################################  
 # Bash script for autoscaling
 # Author: Rafli

            echo "Installing apache dan webserver"
            # melakukan instalasi apache2 webserver
            echo "installing apache2 as $fav"
            apt-get update
            apt-get install apache2 ghostscript libapache2-mod-php mysql-server php php-bcmath php-curl php-imagick php-intl php-json php-mbstring php-mysql php-xml php-zip unzip -y
            a2enmod rewrite
            service apache2 restart
            echo "service apache2 restart"
    
            echo "download landing page"
            # proses instalasi landing-page ke dalam webserver
            wget -O landing-page.zip  https://github.com/sdcilsy/landing-page/archive/refs/heads/master.zip
            echo "extracting compressed file to destination directory"
            unzip landing-page.zip -d /var/www/html/

            # proses instalasi wordpress ke dalam webserver
            echo "download wordpress site"
            wget -O wordpress-id.tar.gz https://id.wordpress.org/latest-id_ID.tar.gz
            echo "extracting content to /var/www/html/"
            tar -xzvf wordpress-id.tar.gz -C /var/www/html/

            #Konfigurasi wordpress
            echo "configure wordpress"
            cp wordpress.conf /etc/apache2/sites-available/
            cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php
            mysql -u root -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
            mysql -u root -e "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY '1234567890';"
            mysql -u root -e "GRANT ALL PRIVILEGES ON wordpress . * TO 'wordpress'@'localhost';"
            mysql -u root -e "FLUSH PRIVILEGES;"

            #set database details with perl find and replace
            sed -i "s/database_name_here/wordpress/g" /var/www/html/wordpress/wp-config.php
            sed -i "s/username_here/wordpress/g" /var/www/html/wordpress/wp-config.php
            sed -i "s/password_here/1234567890/g" /var/www/html/wordpress/wp-config.php

            echo "change into salt key"
            SALT=$(cat saltkey.txt)
            printf '%s\n' "g/'put your unique phrase here'/d" a "$SALT" . w | ed -s  /var/www/html/wordpress/wp-config.php
            
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
    