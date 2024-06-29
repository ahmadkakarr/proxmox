#!/usr/bin/env bash

apt install -y apache2 apache2-utils

systemctl start apache2

systemctl enable apache2

ufw allow http

sudo a2enmod rewrite


sudo a2dissite 000-default.conf



## creating file 
## creating folders 



mkdir -p /var/www/localhost


touch /var/www/localhost/info.php


echo '<?php phpinfo(); ?>' > /var/www/localhost/info.php




## downloading / copying wordpress files to localhost



# permission management
chown www-data:www-data /var/www/html/ -R
chown www-data:www-data /var/www/localhost -R

# sudo chmod -R 755 /var/www


## creating vhosts configs

touch /etc/apache2/sites-available/localhost.conf

cd /etc/apache2/sites-available/
# syntax check
apache2ctl -t
