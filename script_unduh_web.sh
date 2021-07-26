#!/bin/sh
echo "download Landing page"
wget -O landing-page.zip  https://github.com/sdcilsy/landing-page/archive/refs/heads/master.zip
echo "extracting compressed file to destination directory"
sudo unzip landing-page.zip -d /var/www/html
echo "download wordpress site"
wget -O wordpress-id.tar.gz https://id.wordpress.org/latest-id_ID.tar.gz
echo "extracting to /var/www/html"
sudo tar -xzvf wordpress-id.tar.gz -C /var/www/html
echo "download social media site"
wget -O social-media.zip https://github.com/sdcilsy/sosial-media/archive/refs/heads/master.zip
echo "extracting social media site to /var/www/html"
sudo unzip social-media.zip -d /var/www/html
echo "creating table for social media site"
sudo mysqldump -u root -p /var/www/html/social-media-master/dump.sql > social_media.sql
echo "done"
exit 1