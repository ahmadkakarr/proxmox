#!/usr/bin/env bash


while :
do
    read -p "Enter Container ID:" id

    pct stop $id
    pct destroy $id --purge


    echo "Press <CTRL+C> to exit."

done