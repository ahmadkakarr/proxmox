#!/usr/bin/env bash

# bash -c "$(wget -LO - https://raw.githubusercontent.com/ahmadkakarr/proxmox/main/lxc/modules/ct-managemet/delete-lxc-containers.sh)"
while :
do
    read -p "Enter Container ID:" id

    pct stop $id
    pct destroy $id --purge


    echo "Press <CTRL+C> to exit."

done