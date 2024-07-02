sudo apt install software-properties-common -y
sudo curl -LsSo /etc/apt/trusted.gpg.d/mariadb-keyring-2019.gpg https://supplychain.mariadb.com/mariadb-keyring-2019.gpg -y
sudo apt update -y
sudo apt install mariadb-server mariadb-client -y
sudo systemctl enable mariadb
# sudo systemctl status mariadb
sudo mariadb-secure-installation

