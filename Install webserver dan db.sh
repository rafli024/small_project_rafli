#!/bin/bash
PS3='Pilih paket instalasi yang diinginkan : '
install=("Webserver" "Database" "Quit")
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
	    break
            ;;
	"Quit")
	    echo "User requested exit"
	    exit
	    ;;
        *) echo "invalid option $REPLY";;
    esac
done