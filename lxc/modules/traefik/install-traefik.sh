#!/usr/bin/env bash


# one liner
# wget https://github.com/traefik/traefik/releases/download/v3.0.3/traefik_v3.0.3_linux_amd64.tar.gz
function download_traefik() {
 local ver3_0_3='https://github.com/traefik/traefik/releases/download/v3.0.3/traefik_v3.0.3_linux_amd64.tar.gz'
 wget $ver3_0_3
#  https://linuxize.com/post/how-to-extract-unzip-tar-gz-file/
#  tar -xvf archive.tar.gz -C /home/linuxize/files
 sudo tar -xf traefik_v3.0.3_linux_amd64.tar.gz -C /usr/local/bin

}

download_traefik


# mkdir /etc/traefik




