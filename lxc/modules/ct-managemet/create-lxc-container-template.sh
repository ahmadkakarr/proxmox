#!/usr/bin/env bash

# bash -c "$(wget -LO - https://raw.githubusercontent.com/ahmadkakarr/proxmox/main/lxc/modules/ct-managemet/create-lxc-containers.sh)"

declare -A containers_array
declare -A containers_description
declare -A containers_tags
declare -A users_and_passwords



containers_array=( 
  # [200]=traefik-1
  # [201]=nginx-reverse-proxy-1
  # [202]=mariadb-1
  # [203]=php8-fpm-1
  # [204]=phpmyadmin-1
  # [205]=apache2-1
  # [206]=guacamole-1
  # [207]=nginx-ws-1
  # [208]=pihole-1
  # [209]=portainer-1
  # [210]=mongodb-1
  # [211]=bind9-webmin-1
  # [212]=nextcloud-1
  [213]=template-ubuntu-24-04-lts
)

containers_description=( 
  # [200]=traefik-1
  # [201]=nginx-reverse-proxy-1
  # [202]=mariadb-1
  # [203]='Only_PHP-FPM_is_installed_on_this_server'
  # [204]=phpmyadmin-1
  # [205]=apache2-1
  # [206]=guacamole-1
  # [207]=nginx-ws-1
  # [208]=pihole-1
  # [209]=portainer-1
  # [210]=mongodb-1
  # [211]=bind9-webmin-1
  # [212]=nextcloud_Server_1
  [213]=template_ubuntu_24_04_lts


)



containers_tags=( 
  # [200]=traefik-1
  # [201]=nginx-reverse-proxy-1
  # [202]=mariadb-1
  # [203]=php-fpm1
  # [204]=phpmyadmin-1
  # [205]=apache2-1
  # [206]=guacamole-1
  # [207]=nginx-ws-1
  # [208]=pihole-1
  # [209]=portainer-1
  # [210]=mongodb-1
  # [211]=bind9-webmin-1
  # [212]=nextcloud
  [213]=template-ubuntu-24-04-lts

)




## this data can be use to create users and passwrods
users_and_passwords=(
  [ahmad]=kakarr
)



for id in "${!containers_array[@]}"
do


## printing the current container id and name that is going to be created
echo "$id" "${containers_array[$id]}"


id=$id
nameserver=192.168.88.168
searchdomain=srv1.pihole.local
hostname=${containers_array[$id]}
description=${containers_description[$id]}
tags=${containers_tags[$id]}


# pveam list local

pct create $id /var/lib/vz/template/cache/ubuntu-24.04-standard_24.04-2_amd64.tar.zst \
    --arch amd64 \
    --ostype ubuntu \
    --hostname $hostname \
    --cores 2 \
    --memory 1024 \
    --swap 1024 \
    --storage local-lvm \
    --password kakarr \
    --onboot 1 \
    --unprivileged 1 \
    --description $description \
    --nameserver $nameserver \
    --searchdomain $searchdomain \
    --start 1 \
    --tags $tags \
    --features nesting=1,keyctl=1 \
    --net0 name=eth0,bridge=vmbr0,ip=dhcp,type=veth &&\


echo "starting container"
echo "Waiting for container to start"

sleep 3 &&\
# Starting to execute command in container untill 'EOF' Received
    pct exec $id sh <<EOF

    echo "Updaing system OS Pakcages"
    apt update -y 
    apt dist-upgrade -y
    apt clean
    apt autoremove
    echo "OS Packages Updated"

    apt install ca-certificates curl gnupg lsb-release ntp htop zip unzip gnupg apt-transport-https ca-certificates net-tools ncdu apache2-utils -y

    echo 'vm.swappiness=10' >> /etc/sysctl.conf
    echo 'vm.vfs_cache_pressure = 50' >> /etc/sysctl.conf
    echo 'fs.inotify.max_user_watches=262144' >> /etc/sysctl.conf


    echo "Adding user"
    useradd -c "default account" -u 1112 -s /bin/bash --group users -G sudo -m -d /home/ahmad ahmad
    echo 'ahmad:kakarr' | chpasswd


    apt install acl
EOF
done
pct template $id


