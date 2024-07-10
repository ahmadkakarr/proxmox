

declare -A containers_hostname
declare -A containers_hostname
declare -A containers_description


  # [213]=template-ubuntu-24-04-lts

containers_newid=( 
  [213]=214
  [213]=215
)



containers_hostname=( 
  [214]=nginx-webapp-1
  [215]=nginx-webapp-2
)


containers_description=( 
  [214]=nginx-webapp-1-for-testing-nginx-reverse-proxy
  [215]=nginx-webapp-2-for-testing-nginx-reverse-proxy
)


for id in "${!containers_newid[@]}"
do



echo "$id" "${containers_array[$id]}"

id=$id
newid=${containers_newid[$id]}
hostname=${containers_hostname[$newid]}
description=${containers_description[$id]}


id=$id
pct clone $id $newid \
    --hostname $hostname \
    --description $description \
    --full 1

pct start $newid