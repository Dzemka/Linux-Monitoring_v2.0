#!/bin/bash
. checkParams.sh

error=$(checkParams "$@")
if [ -n "$error" ]; then
  echo "$error"
  exit
fi

echo "Enter log file"
read -rp "File: " logFile

if [ "$1" -eq 1 ]; then
 cat $logFile | sort -k 9
elif [ "$1" -eq 2 ]; then
    cat $logFile | awk '{print $1}' | uniq
elif [ "$1" -eq 3 ]; then
  cat $logFile | awk '{ if ( $9 <= 503 && $9 >= 400 )
                        print $6 " " $7 " " $8}'
elif [ "$1" -eq 4 ]; then
  cat $logFile | awk '{ if ( $9 <= 500 && $9 >= 400 )
                        print $1 }' | uniq
fi
