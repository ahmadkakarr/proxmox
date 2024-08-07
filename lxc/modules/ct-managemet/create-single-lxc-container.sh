#!/usr/bin/env bash

declare -A containers_array
declare -A users_and_passwords


containers_array=( 
  [200]=traefik
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
hostname=${containers_array[$id]}



pct create $id /var/lib/vz/template/cache/ubuntu-22.04-standard_22.04-1_amd64.tar.zst \
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
    --features nesting=1,keyctl=1 \
    --net0 name=eth0,bridge=vmbr0,ip=dhcp,type=veth \
    --template 1 &&\
echo "starting container"
pct start $id &&\
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
    apt clean
    apt autoremove
    rm /etc/ssh/ssh_host_*
    truncate -s 0 /etc/machine-id


EOF



done



