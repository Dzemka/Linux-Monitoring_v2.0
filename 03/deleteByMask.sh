#!/bin/bash

function deleteByMask {
    echo "Enter the mask by example: \"letters_DDMMYY\""
    read -rp "Mask: " mask
    if ! echo "$mask" | grep -qE '^[a-zA-Z]+[.]{0,1}[a-zA-Z]{0,}_[0-9]{2}[0-9]{2}[0-9]{2}$'; then
      echo "Incorrect mask"
    fi
    mask=($(echo $mask | grep -o .))
    index=0
    while [[ "${mask[$index]}" != "_" ]] && [[ "${mask[$index]}" != "." ]] ; do
      mask[$index]+="+"
      index=$((index + 1))
    done
    mask=$(echo ${mask[@]} | sed 's/ //g')
    find /home/ -regex ".*$mask$" | xargs rm -rf
}