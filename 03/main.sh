#!/bin/bash

. ./checkParams.sh

checkParams=$(isCorrect $@);

if [ ! -z "$checkParams" ]; then
  echo "$checkParams"
fi

if [ "$1" -eq 1 ]; then
  read -rp "Enter name of log file: " fileName
  res=$( < "$fileName" awk '{print $1}')
  for fileToDelete in $res; do
    if [ "$fileToDelete" != "Start" ]; then
      rm -rf "$fileToDelete"
    fi
  done
elif [ "$1" -eq 2 ]; then
    echo "Enter the minimum and maximum date and time according to the sample \$(date +\"%Y-%m-%d %H:%M:%S\")"
    read -rp "Start : " start
    if ! echo "$start" | grep -qE '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'; then
      echo "Incorrect date"
      exit
    fi
    read -rp "End : " end
    if ! echo "$end" | grep -qE '^[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}$'; then
      echo "Incorrect date"
      exit
    fi
    flag=0
    files=$(find . -exec stat {} \; | grep -e " Birth" -e "File" | sed -e 's/ File: //g' -e 's/ Birth: //g')
    IFS=$'\n'
    for value in $files; do
      if [ $flag -eq 0 ]; then
        fileName=$value
        flag=1;
      else
        date=$(echo "$value" | awk -F. '{NF--; print}')
        if [ "$date" \> "$start" -a "$date" \< "$end" ]; then
          echo "$fileName"
#          rm -rf "$fileName"
        fi
        flag=0
      fi
    done
    elif [ "$1" -eq 3 ]; then
      echo "Enter the mask by example: \"letters_DDMMYY\""
      read -rp "Mask: " mask
      if ! echo "$mask" | grep -qE '^[a-zA-Z]+[.]{0,1}[a-zA-Z]{0,}_[0-9]{2}[0-9]{2}[0-9]{2}$'; then
        echo "Incorrect mask"
      fi
      array=()
      lengthMask=${#mask}
      isDate=0
      for (( i = 0; i < lengthMask; i++ )); do
        if [ "${mask:i:1}" == '_' ]; then
          isDate=1
        fi
        array[i]="${mask:$i:1}"
        if [ $isDate -ne 1 ]; then
          array[i]+="+"
        fi
      done
        IFS=;
        find /home -name "${array[*]}"
fi

