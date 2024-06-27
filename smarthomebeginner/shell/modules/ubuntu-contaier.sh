#!/usr/bin/env bash

# Copyright (c) 2021-2024 ahmadkakarr
# Author: Ahmad Hassan Khan
# License: MIT
# https://pve.proxmox.com/pve-docs/chapter-pct.html
# https://pve.proxmox.com/pve-docs/pve-admin-guide.html
# https://github.com/rgl/proxmox-ve/blob/master/example/provision-containers.sh
# https://ioflood.com/blog/export-linux-command/#:~:text=TL%3BDR%3A%20What%20is%20the,available%20to%20all%20child%20processes.
# https://stackoverflow.com/questions/11955298/use-sudo-with-password-as-parameter
# https://www.howtoforge.com/how-to-install-syncthing-on-ubuntu-22-04/
# my-notes-syncthing-url




read -p "Enter Container ID:" id


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
