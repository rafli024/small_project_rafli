#!/bin/bash
PS3='Pilih Opsi : '
install=("Webserver" "Database" "Download web file" "Uninstall" "Quit")
select fav in "${install[@]}"; do
    case $fav in
        "Webserver")
            echo "Installing $fav"
            # melakukan instalasi apache2 webserver
            echo "installing apache2 as $fav"
            sudo apt-get install apache2
            ;;
        "Database")
            echo "Installing $fav"
	        # melakukan instalasi Mysql database
            echo "installing mysql as $fav"
            sudo apt-get install mysql-server
            ;;
        "Download web file")
            echo "download Landing page"
            wget -O landing-page.zip  https://github.com/sdcilsy/landing-page/archive/refs/heads/master.zip
            echo "extracting compressed file to destination directory"
            sudo unzip landing-page.zip -d /var/www/html
            echo "download wordpress site"
            wget -O wordpress-id.tar.gz https://id.wordpress.org/latest-id_ID.tar.gz
            echo "extracting to /var/www/html"
            sudo tar -xzvf wordpress-id.tar.gz -C /var/www/html
            echo "download social media site"
            wget -O social_media.zip https://github.com/sdcilsy/sosial-media/archive/refs/heads/master.zip
            echo "extracting social media site to /var/www/html"
            sudo unzip social-media.zip -d /var/www/html
            echo "creating table for social media site"
            sudo mysql -u root -p -e "create database sosial_media_master"
            sudo mysql -u root -p sosial_media < /var/www/html/sosial-media-master/dump.sql
            echo "done"
            ;;
        "Uninstall")
            sudo mysql -u root -p -e "drop database sosial_media"
            sudo apt  remove apache2* -y
            sudo apt remove mysql-server* -y
            sudo apt purge apache2* -y
            sudo apt purge mysql-server* -y
            sudo apt auto-clean
	    break
            ;;
	"Quit")
	    echo "User requested exit"
	    exit
	    ;;
        *) echo "invalid option $REPLY";;
    esac
done