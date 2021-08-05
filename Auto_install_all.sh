#!/bin/bash

#######################################  
 # Bash script for autoscaling
 # Author: Rafli

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
 
            #set database details with perl find and replace
            sed -i "s/database_name_here/wordpress/g" /var/www/html/wordpress/wp-config.php
            sed -i "s/username_here/wordpress/g" /var/www/html/wordpress/wp-config.php
            sed -i "s/password_here/1234567890/g" /var/www/html/wordpress/wp-config.php

            echo "change into salt key"
            SALT=$(curl -L https://api.wordpress.org/secret-key/1.1/salt/)
            printf '%s\n' "g/'put your unique phrase here'/d" a "$SALT" . w | ed -s  /var/www/html/wordpress/wp-config.php
            
            echo "download social media site"
            wget -O social_media.zip https://github.com/sdcilsy/sosial-media/archive/refs/heads/master.zip

            echo "extracting social media site to /var/www/html"
            unzip social_media.zip -d /var/www/html/
            exit 1
    