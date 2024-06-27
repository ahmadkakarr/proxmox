```shell
bash -c "$(wget -LO - https://raw.githubusercontent.com/ahmadkakarr/proxmox/main/hs-install.sh)"
```

```shell
bash -c "$(wget -LO - https://raw.githubusercontent.com/ahmadkakarr/proxmox/main/lxc/modules/ct-managemet/create-lxc-containers.sh)"
```

```shell
bash -c "$(wget -LO - https://raw.githubusercontent.com/ahmadkakarr/proxmox/main/lxc/modules/create-single-lxc-container.sh)"
```

```shell
bash -c "$(wget -LO - https://raw.githubusercontent.com/ahmadkakarr/proxmox/main/lxc/modules/delete-lxc-containers.sh)"
```

```shell
pct exec 1000 -- su -c "docker compose -f /home/ahmad/dockerstack/docker-compose-hs.yml  logs -tf --tail="50" socket-proxy" ahmad
```

pct destroy 1000 --purge
pct stop 1000
