#!/usr/bin/env bash
apt install php8.3-fpm php8.3-mysql php8.3-cli php8.3-common php8.3-opcache php8.3-readline php8.3-mbstring php8.3-xml php8.3-gd php8.3-curl php8.3-imagick -y
systemctl enable php8.3-fpm
systemctl start php8.3-fpm
a2enmod proxy_fcgi setenvif
a2enconf php8.3-fpm
systemctl restart php8.3-fpm
sudo cp /etc/php/8.3/fpm/pool.d/www.conf /etc/php/8.3/fpm/pool.d/default-www.conf 
systemctl status php8.3-fpm
