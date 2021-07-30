#!/bin/bash
echo "anda perlu menjalankan script ini menggunakan root, jika tidak pilih 5 dan masuk kembali sebagai root"
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
            unzip landing-page.zip -d /var/www/html
            # proses instalasi wordpress ke dalam webserver
            echo "download wordpress site"
            wget -O wordpress-id.tar.gz https://id.wordpress.org/latest-id_ID.tar.gz
            echo "extracting content to /var/www/html"
            tar -xzvf wordpress-id.tar.gz -C /var/www/html
            echo "configure wordpress"
            
             mysql -u root -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
            mysql -u root -p -e "CREATE USER 'wordpress'@'localhost' IDENTIFIED BY '1234567890';"
            mysql -u root -p -e "GRANT ALL PRIVILEGES ON * . * TO 'wordpress'@'localhost';"
            mysql -u root -p -e "FLUSH PRIVILEGES;"
            echo "download social media site"
            wget -O social_media.zip https://github.com/sdcilsy/sosial-media/archive/refs/heads/master.zip
            echo "extracting social media site to /var/www/html"
            unzip social-media.zip -d /var/www/html
            echo "copy wordpress conf file"
            cp wordpress.conf /etc/apache2/sites-available/wordpress.conf
            echo "configuring database"
            echo "creating dbusername and dbpassword"
            mysql -u root -p -e "CREATE USER 'devopscilsy'@'localhost' IDENTIFIED BY '1234567890';"
            mysql -u root -p -e "GRANT ALL PRIVILEGES ON * . * TO 'devopscilsy'@'localhost';"
            mysql -u root -p -e "FLUSH PRIVILEGES;"
            echo "creating database for social media site"
            mysql -u root -p -e "create database dbsosmed"
            mysql -u devopscilsy -p dbsosmed < /var/www/html/sosial-media-master/dump.sql
            echo "done"
            ;;
        "Uninstall")
            mysql -u root -p -e "drop database dbsosmed"
            apt  remove apache2* -y
            apt remove mysql-server* -y
            apt purge apache2* -y
            apt purge mysql-server* -y
            apt auto-clean
            rm -rf /var/*
	    break
            ;;
	"Quit")
	    echo "User requested exit"
	    exit
	    ;;
        *) echo "invalid option $REPLY";;
    esac
done