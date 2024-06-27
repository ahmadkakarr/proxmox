read -p "Enter Container ID:" id
ahmad_password=kakarr


pct exec $id 

pct exec 700 -- su -c "echo 'kakarr' | sudo -S apt updae" ahmad # or change it to vagrant.
pct exec $pve_id -- sh -c -S "echo 'root:vagrant' | chpasswd"  # or change it to vagrant.


    su -c 'mkdir /home/ahmad/dockerstack' ahmad
