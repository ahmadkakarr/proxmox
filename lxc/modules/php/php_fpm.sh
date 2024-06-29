#!/usr/bin/env bash
apt install php8.3 libapache2-mod-php8.3 php8.3-mysql php-common php8.3-cli php8.3-common php8.3-opcache php8.3-readline php8.3-mbstring php8.3-xml php8.3-gd php8.3-curl -y
apt install php8.3-fpm -y
systemctl enable php8.3-fpm
systemctl start php8.3-fpm
a2enmod proxy_fcgi setenvif
a2enconf php8.3-fpm
systemctl restart php8.3-fpm
systemctl status php8.3-fpm
