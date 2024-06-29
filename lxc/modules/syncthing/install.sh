apt install gnupg2 curl apt-transport-https -y
curl -fsSL https://syncthing.net/release-key.txt | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/syncthing.gpg
echo "deb https://apt.syncthing.net/ syncthing release" | sudo tee /etc/apt/sources.list.d/syncthing.list
apt update
apt install syncthing
systemctl start syncthing@ahmad.service
systemctl enable syncthing@ahmad.service
# systemctl status syncthing@ahmad.service
ufw allow syncthing
ufw allow syncthing-gui
ufw allow OpenSSH
# ufw status verbose
syncthing --paths
nano /home/ahmad/.local/state/syncthing/config.xml