sudo apt install software-properties-common -y
sudo add-apt-repository ppa:ondrej/nginx -y
sudo apt update
sudo apt dist-upgrade -y
sudo apt install nginx -y
sudo systemctl status nginx
