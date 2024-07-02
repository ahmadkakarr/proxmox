#!/usr/bin/env bash



# install nginx and php-fpm 
# [lemp-1](https://spinupwp.com/hosting-wordpress-yourself-nginx-php-mysql/)


## install nginx
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/nginx -y
sudo apt update
sudo apt dist-upgrade -y
sudo apt install nginx -y
# sudo systemctl status nginx

## install php

sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update -y
sudo apt install php8.3-fpm -y
# sudo apt install php8.3-common -y
sudo apt install php8.3-mysql -y
# sudo apt install php8.3-xml  -y
# sudo apt install php8.3-intl php8.3-curl php8.3-gd -y
# sudo apt install php8.3-imagick  -y
# sudo apt install php8.3-cli -y
# sudo apt install php8.3-dev -y
# sudo apt install php8.3-imap -y
# sudo apt install php8.3-mbstring -y
# sudo apt install php8.3-opcache -y
# sudo apt install php8.3-redis -y
# sudo apt install php8.3-soap -y
# sudo apt install php8.3-zip -y


## Install phpmyadmin
# Check the latest version https://www.phpmyadmin.net/
wget -c https://files.phpmyadmin.net/phpMyAdmin/5.2.1/phpMyAdmin-5.2.1-english.tar.gz
tar -xzvf phpMyAdmin-5.2.1-english.tar.gz
rm phpMyAdmin-5.2.1-english.tar.gz
sudo mv phpMyAdmin-5.2.1-english /usr/share/phpmyadmin

ln -s /usr/share/phpmyadmin /var/www/phpmyadmin


ln -s /etc/nginx/sites-available/phpmyadmin /etc/nginx/sites-enabled/phpmyadmin