
# bash -c "$(wget -LO - https://raw.githubusercontent.com/ahmadkakarr/proxmox/main/lxc/modules/ct-managemet/clone-lxc-containers-template.sh)"

declare -A containers_hostname
declare -A containers_hostname
declare -A containers_description


  # [213]=template-ubuntu-24-04-lts

id=213



containers_hostname=( 
  [214]=nginx-webapp-1
  [215]=nginx-webapp-2
)


containers_description=( 
  [214]=nginx-webapp-1-for-testing-nginx-reverse-proxy
  [215]=nginx-webapp-2-for-testing-nginx-reverse-proxy
)


declare -a new_container_id=( "214" "215" )


for newid in "${!new_container_id[@]}"
do
 
  hostname=${containers_hostname[$newid]}
  description=${containers_description[$newid]}
  echo "$newid" 
  echo "$hostname" 
  echo "$description" 

  pct clone $id $newid --full 1
  pct start $newid
done

