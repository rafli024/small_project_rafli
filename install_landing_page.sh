#!/bin.sh
install_landingpage(){
        jawaban = "Y"
    read -p "apakah anda ingin mendownload landing_page ? Y/n" pilih;
    if [ $pilih == $jawaban ]
    echo "downloading landing page"
    wget https://github.com/sdcilsy/landing-page/archive/refs/heads/master.zip
    echo "Ekstrak File"
    echo "=============================>"
    unzip master.zip
    echo "=============================>"
    echo "Memindahkan data"
    echo "=============================>"
    sudo rm /var/www/html/
    sudo rm -R /var/www/html/*
    sudo mkdir /var/www/html/landing_page
    sudo mv sosial-media-master/* /var/www/html
    echo "Setup selesai"
    echo "lanjut install wordpress"
    install_wordpress
else
echo "Setup dibatalkan"
exit 1
fi
}
install_wordpress(){
    jawaban_wd = "Y"
    read -p "apakah anda ingin menginstall wordpress ? (Y/n)" pilih_wd;
if [ $pilih_wd == $jawaban_wd]
    wget https://id.wordpress.org/latest-id_ID.tar.gz
    echo "ekstrak wordpress"
    tar -xzvf latest-id_ID.tar.gz
    echo "memindahkan wordpress ke dalam webserver"
    sudo cp /wordpress /var/www/html/

else
    echo "Setup dibatalkan"
    exit 1
fi
}
installsocialmedia(){
    jawaban_sosmed = "Y"
    read -p  "apakah anda ingin menginstall sosial media ? (Y/n)" pilih_sosmed;
    if [ $pilih_sosmed == $jawaban_sosmed ]
    echo "download social media"
    wget https://github.com/sdcilsy/sosial-media/archive/refs/heads/master.zip
    echo "memindahkan kedalam webserver"
    
}