# use the if command to check if the user is root or not
# use the bash aliasis to execute bunch of following command to fix permission issues

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