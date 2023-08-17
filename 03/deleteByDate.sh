#!/bin/bash

function deleteByDate {
echo "Enter the minimum and maximum date and time according to the sample \$(date +\"%F %T\")"
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

    function getS () {
      file=($( stat $1 | awk '{ if (NR == 1) print $2; if (NR == 3) print $4}' ))
      {
        creationDate=$(sudo debugfs -R 'stat <'${file[1]}'>' $(df ${file[0]} | awk 'NR==2 {print $1}') | awk 'NR==10 {print $5" "$6" "$7" "$8}')
      } &>/dev/null
      creationDate=$(date -d "$creationDate" +"%F %T")

    if [ "$creationDate" \> "$2" -a "$creationDate" \< "$3" ]; then
          rm -rf "${file[0]}"
        fi
    }
    export -f getS
    files=$(find /home -exec bash -c ' getS "$@" "'"$start"'" "'"$end"'" ' bash {} \; 2>/dev/null)
}
