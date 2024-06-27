#!/usr/bin/env bash



read -p "Enter Container ID:" id
read -p "Enter Hostname:" hostname


ahmad_password=kakarr

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


    apt install acl

EOF

# install docker
pct exec $id -- su -c "sudo install -m 0755 -d /etc/apt/keyrings" 
pct exec $id -- su -c "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo -S gpg --dearmor -o /etc/apt/keyrings/docker.gpg" 
pct exec $id -- su -c 'echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null'
pct exec $id -- su -c "apt update"
pct exec $id -- su -c "apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y"



pct exec $id sh <<-EOF

adduser ahmad docker

su -c 'mkdir /home/ahmad/dockerstack' ahmad
su -c 'mkdir /home/ahmad/dockerstack/appdata' ahmad
su -c 'mkdir /home/ahmad/dockerstack/compose' ahmad
su -c 'mkdir /home/ahmad/dockerstack/compose/hs' ahmad
su -c 'mkdir /home/ahmad/dockerstack/logs' ahmad
su -c 'mkdir /home/ahmad/dockerstack/logs/hs' ahmad
su -c 'mkdir /home/ahmad/dockerstack/logs/hs/traefik' ahmad
su -c 'touch /home/ahmad/dockerstack/logs/hs/traefik/traefik.log' ahmad
su -c 'touch /home/ahmad/dockerstack/logs/hs/traefik/access.log' ahmad
su -c 'mkdir /home/ahmad/dockerstack/scripts' ahmad
su -c 'mkdir /home/ahmad/dockerstack/secrets' ahmad
su -c 'mkdir /home/ahmad/dockerstack/shared' ahmad
su -c 'touch /home/ahmad/dockerstack/.env' ahmad


su -c 'wget -P /home/ahmad/dockerstack/ https://raw.githubusercontent.com/ahmadkakarr/proxmox/main/smarthomebeginner/docker/docker-compose-hs.yml' ahmad
su -c 'wget -P /home/ahmad/dockerstack/compose/hs/ https://raw.githubusercontent.com/ahmadkakarr/proxmox/main/smarthomebeginner/docker/compose/hs/socket-proxy.yml' ahmad


echo 'PUID=1112' >> /home/ahmad/dockerstack/.env
echo 'PGID=1112' >> /home/ahmad/dockerstack/.env
echo 'TZ="Asia/Karachi"' >> /home/ahmad/dockerstack/.env
echo 'USERDIR="/home/ahmad"' >> /home/ahmad/dockerstack/.env
echo 'DOCKERDIR="/home/ahmad/dockerstack"' >> /home/ahmad/dockerstack/.env
echo 'SECRETSDIR="/home/ahmad/dockerstack/secrets"' >> /home/ahmad/dockerstack/.env
echo 'DATADIR="/media/dockerstack"' >> /home/ahmad/dockerstack/.env
echo 'HOSTNAME="hs"' >> /home/ahmad/dockerstack/.env
echo 'DOMAINNAME_1=digitalstudio.ltd' >> /home/ahmad/dockerstack/.env
echo 'LOCAL_IPS=127.0.0.1/32,10.0.0.0/8,192.168.0.0/16,172.16.0.0/12' >> /home/ahmad/dockerstack/.env
echo 'CLOUDFLARE_IPS=173.245.48.0/20,103.21.244.0/22,103.22.200.0/22,103.31.4.0/22,141.101.64.0/18,108.162.192.0/18,190.93.240.0/20,188.114.96.0/20,197.234.240.0/22,198.41.128.0/17,162.158.0.0/15,104.16.0.0/13,104.24.0.0/14,172.64.0.0/13,131.0.72.0/22' >> /home/ahmad/dockerstack/.env


htpasswd -cBb /home/ahmad/dockerstack/secrets/basic_auth_credentials ahmad kakarr

cat ./secrets/basic_auth_credentials
sudo chown root:root /home/ahmad/dockerstack/secrets/basic_auth_credentials

sudo touch /home/ahmad/dockerstack/secrets/cf_dns_api_token
sudo echo 'PAST-YOUR-API-TOKEN' >> /home/ahmad/dockerstack/secrets/cf_dns_api_token



su -c 'mkdir /home/ahmad/dockerstack/appdata/traefik3' ahmad
su -c 'mkdir /home/ahmad/dockerstack/appdata/traefik3/acme' ahmad
su -c 'mkdir /home/ahmad/dockerstack/appdata/traefik3/rules' ahmad
su -c 'mkdir /home/ahmad/dockerstack/appdata/traefik3/rules/hs' ahmad


su -c 'mkdir /home/ahmad/dockerstack/appdata/redis' ahmad
su -c 'mkdir /home/ahmad/dockerstack/appdata/redis/data' ahmad



su -c 'touch /home/ahmad/dockerstack/appdata/traefik3/acme/acme.json' ahmad
su -c 'touch /home/ahmad/dockerstack/appdata/traefik3/rules/hs/tls-opts.yml' ahmad
su -c 'touch /home/ahmad/dockerstack/appdata/traefik3/rules/hs/middlewares-basic-auth.yml' ahmad


chmod 775 /home/ahmad/dockerstack
setfacl -Rdm u:ahmad:rwx /home/ahmad/dockerstack
setfacl -Rm u:ahmad:rwx /home/ahmad/dockerstack
setfacl -Rdm g:docker:rwx /home/ahmad/dockerstack
setfacl -Rm g:docker:rwx /home/ahmad/dockerstack

chown root:root /home/ahmad/secrets
chmod 600 /home/ahmad/dockerstack/.env
chmod 600 /home/ahmad/secrets
chmod 600 /home/ahmad/dockerstack/appdata/traefik3/acme/acme.json
chmod 600 /home/ahmad/dockerstack/appdata/traefik3/rules/hs/tls-opts.yml
chmod 600 /home/ahmad/dockerstack/appdata/traefik3/rules/hs/middlewares-basic-auth.yml


docker compose -f /home/ahmad/dockerstack/docker-compose-hs.yml up -d



EOF
