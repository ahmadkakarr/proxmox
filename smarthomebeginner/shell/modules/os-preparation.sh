#!/usr/bin/env bash



read -p "Enter Container ID:" id

ahmad_password=kakarr

pct create $id /var/lib/vz/template/cache/ubuntu-24.04-standard_24.04-2_amd64.tar.zst \
    --arch amd64 \
    --ostype ubuntu \
    --hostname $id \
    --cores 2 \
    --memory 1024 \
    --swap 1024 \
    --storage local-lvm \
    --password kakarr \
    --onboot 1 \
    --unprivileged 1 \
    --net0 name=eth0,bridge=vmbr0,ip=dhcp,type=veth  &&\
echo "starting container"
pct start $id &&\
echo "Waiting for container to start"

sleep 10 &&\
# Starting to execute command in container untill 'EOF' Received
    pct exec $id sh <<EOF
    export ahmad_password=kakarr
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



    apt install acl python3-pip python3-setuptools docker.io docker-compose -y
    adduser ahmad docker

EOF

# Docker install not working on ubuntu lxc 2204
    # apt-get install ca-certificates curl
    # install -m 0755 -d /etc/apt/keyrings
    # curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    # chmod a+r /etc/apt/keyrings/docker.asc

    # echo \
    # "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    # $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    # sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    # apt-get update

    # apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    pct exec $id sh <<-EOF1

    su -c 'mkdir /home/ahmad/dockerstack' ahmad
    su -c 'mkdir /home/ahmad/dockerstack/appdata' ahmad
    su -c 'mkdir /home/ahmad/dockerstack/compose' ahmad
    su -c 'mkdir /home/ahmad/dockerstack/logs' ahmad
    su -c 'mkdir /home/ahmad/dockerstack/scripts' ahmad
    su -c 'mkdir /home/ahmad/dockerstack/secrets' ahmad
    chmod 600 /home/ahmad/dockerstack/secrets
    su -c 'mkdir /home/ahmad/dockerstack/shared' ahmad
    su -c 'touch /home/ahmad/dockerstack/.env' ahmad
    chmod 600 /home/ahmad/dockerstack/.env

    chmod 775 /home/ahmad/dockerstack
    setfacl -Rdm u:ahmad:rwx /home/ahmad/dockerstack
    setfacl -Rm u:ahmad:rwx /home/ahmad/dockerstack
    setfacl -Rdm g:docker:rwx /home/ahmad/dockerstack
    setfacl -Rm g:docker:rwx /home/ahmad/dockerstack

        cat > /home/ahmad/dockerstack/.env <<-EOF2
        PUID=1112
        PGID=1112
        TZ="Europe/Zurich"
        USERDIR="/home/ahmad"
        DOCKERDIR="/home/ahmad/docker"
        DATADIR="/media/dockerstack"
        HOSTNAME="udms"
    EOF2
EOF1
