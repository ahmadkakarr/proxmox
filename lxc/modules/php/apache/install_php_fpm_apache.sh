# https://php.watch/articles/php-8.3-install-upgrade-on-debian-ubuntu
# https://tecadmin.net/how-to-install-apache-with-php-fpm-on-ubuntu-22-04/
sudo apt install apache2 -y
sudo systemctl start apache2 
sudo systemctl enable apache2 

apt install software-properties-common -y 
sudo add-apt-repository ppa:ondrej/php -y
apt update
apt install php8.3-common php8.3-cli php8.3-fpm php8.3-{curl,bz2,mbstring,intl} -y

sudo systemctl start php8.3-fpm 
sudo systemctl enable php8.3-fpm 



# sudo apt search php8.3-imagick

apt install php8.3-imagick/noble -y
apt install php8.3-redis/noble -y


sudo a2dismod mpm_prefork
sudo a2enmod mpm_event 
sudo a2enmod proxy 
sudo a2enmod headers rewrite
sudo a2enmod proxy_fcgi setenvif proxy 
sudo a2enconf php8.3-fpm

systemctl restart apache2