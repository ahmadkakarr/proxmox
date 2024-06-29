## Traefik Config sync Folders on remote server

/home/ahmad/Sync/traefik/static/config
/home/ahmad/Sync/traefik/dynamic/config/provider/file
/home/ahmad/Sync/traefik/logs
/home/ahmad/Sync/traefik/acme

## Traefik Config sync Folders on admin computer

C:\Users\ahmad\proxmox\lxc\traefik\static\config
C:\Users\ahmad\proxmox\lxc\traefik\dynamic\config\provider\file
C:\Users\ahmad\proxmox\lxc\traefik\logs
C:\Users\ahmad\proxmox\lxc\traefik\acme

## using symbolic links for traefik config

https://linuxize.com/post/how-to-create-symbolic-links-in-linux-using-the-ln-command/

### for static configs

sudo ln -s /home/ahmad/Sync/traefik/static/config/traefik.yml /etc/traefik/traefik.yml

### for file provider configs (Dynamic)

## php-apache Config sync Folders on remote server

/home/ahmad/Sync/apache/conf/sites-available
/home/ahmad/Sync/apache/sites

## php-apache Config sync Folders on admin computer

C:\Users\ahmad\proxmox\lxc\apache\conf\sites-available
C:\Users\ahmad\proxmox\lxc\apache\sites

## Enabling site in apache

<!-- sudo unlink 000-default.conf -->

chown -R www-data:www-data /var/run/apache2

sudo chmod -R 755 /var/www/html/flaskproject

```
<Directory /var/www/html/flaskproject>
    Options +FollowSymLinks
    # ... other configuration ...
</Director

```

https://community.linuxmint.com/software/view/links2

sudo tail -f /var/log/apache2/error.log

sudo ln -s /home/ahmad/Sync/apache/conf/sites-available/example.com.conf /etc/apache2/sites-enabled/example.com.conf

link default web page
sudo ln -s /home/ahmad/Sync/apache/conf/sites-available/000-default.conf /etc/apache2/sites-enabled/000-default.conf

sudo ln -s /home/ahmad/Sync/apache/conf/sites-available/localhost.conf /etc/apache2/sites-enabled/localhost.conf

sudo cp /home/ahmad/Sync/apache/conf/sites-available/localhost.conf /etc/apache2/sites-available

## Copying websites

sudo ln -s /home/ahmad/Sync/apache/sites/html /var/www
sudo ln -s /home/ahmad/Sync/apache/sites/my-html /var/www

sudo cp -rs /home/ahmad/Sync/apache/sites/my-html /var/www

sudo usermod -a -G www-data ahmad

sudo cp Sync/apache/conf/sites-available/000-default.conf /etc/apache2/sites-available/
ln -s /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-enabled/000-default.conf
