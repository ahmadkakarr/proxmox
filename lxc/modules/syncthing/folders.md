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
