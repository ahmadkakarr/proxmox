#!/usr/bin/env bash

# install nginx and php-fpm 


## install nginx
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/nginx -y
sudo apt update
sudo apt dist-upgrade -y
sudo apt install nginx -y
sudo systemctl status nginx

## install php

sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/php -y
sudo apt update -y
sudo apt install php8.3-fpm php8.3-common -y
sudo apt install php8.3-mysql -y
sudo apt install php8.3-xml  -y
sudo apt install php8.3-intl php8.3-curl php8.3-gd -y
# sudo apt install php8.3-imagick  -y
sudo apt install php8.3-cli -y
sudo apt install php8.3-dev -y
sudo apt install php8.3-imap -y
sudo apt install php8.3-mbstring -y
sudo apt install php8.3-opcache -y
sudo apt install php8.3-redis -y
sudo apt install php8.3-soap -y
sudo apt install php8.3-zip -y