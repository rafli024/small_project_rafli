#!/bin/bash
PS3='Pilih Opsi : '
install=("Webserver" "Database" "Download web file" "Uninstall" "Quit")
select fav in "${install[@]}"; do
    case $fav in
        "Webserver")
            echo "Installing $fav"
            # melakukan instalasi apache2 webserver
            echo "installing apache2 as $fav"
            sudo apt-get install apache2 -y
            ;;
        "Database")
            echo "Installing $fav"
	        # melakukan instalasi Mysql database
            echo "installing mysql as $fav"
            sudo apt-get install mysql-server -y
            ;;
        "Download web file")
            echo "download $fav"
            wget -O landing-page.zip  https://github.com/sdcilsy/landing-page/archive/refs/heads/master.zip
            echo "extracting compressed file to destination directory"
            sudo unzip landing-page.zip -d /var/www/html
            echo "download wordpress site"
            wget -O wordpress-id.tar.gz https://id.wordpress.org/latest-id_ID.tar.gz
            echo "extracting content to /var/www/html"
            sudo tar -xzvf wordpress-id.tar.gz -C /var/www/html
            echo "download social media site"
            wget -O social_media.zip https://github.com/sdcilsy/sosial-media/archive/refs/heads/master.zip
            echo "extracting social media site to /var/www/html"
            sudo unzip social-media.zip -d /var/www/html
            echo "copy wordpress conf file"
            sudo cp wordpress.conf /etc/apache2/sites-available/wordpress.conf
            echo "configuring database"
            sudo mysql -u root -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
            sudo mysql -u root -p -e "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY '1234567890';"
            sudo mysql -u root -p -e "GRANT ALL PRIVILEGES ON * . * TO 'wordpress'@'localhost';"
            sudo mysql -u root -p -e "FLUSH PRIVILEGES;"
            echo "creating dbusername and dbpassword"
            sudo mysql -u root -p -e "CREATE USER 'devopscilsy'@'localhost' IDENTIFIED BY '1234567890';"
            sudo mysql -u root -p -e "GRANT ALL PRIVILEGES ON * . * TO 'devopscilsy'@'localhost';"
            sudo mysql -u root -p -e "FLUSH PRIVILEGES;"
            echo "creating database for social media site"
            sudo mysql -u root -p -e "create database dbsosmed"
            sudo mysql -u devopscilsy -p dbsosmed < /var/www/html/sosial-media-master/dump.sql
            echo "done"
            ;;
        "Uninstall")
            sudo mysql -u root -p -e "drop database dbsosmed"
            sudo apt  remove apache2* -y
            sudo apt remove mysql-server* -y
            sudo apt purge apache2* -y
            sudo apt purge mysql-server* -y
            sudo apt auto-clean
            sudo rm -rf /var/*
	    break
            ;;
	"Quit")
	    echo "User requested exit"
	    exit
	    ;;
        *) echo "invalid option $REPLY";;
    esac
done