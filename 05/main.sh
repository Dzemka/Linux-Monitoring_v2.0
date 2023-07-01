#!/bin/bash
. checkParams.sh

error=$(checkParams "$@")
if [ -n "$error" ]; then
  echo "$error"
fi

echo "Enter log file"
read -rp "File: " logFile

echo "$logFile"

if [ "$1" -eq 1 ]; then
 < "$logFile" sort -k 9
elif [ "$1" -eq 2 ]; then
    < "$logFile" awk '{print $1}' | uniq -u
elif [ "$1" -eq 3 ]; then
  < "$logFile" awk '{ if ( $9 <= 500 && $9 >= 400 )
                        print $6 " " $7 " " $8}'
elif [ "$1" -eq 4 ]; then
  < "$logFile" awk '{ if ( $9 <= 500 && $9 >= 400 )
                        print $1 }' | uniq -u
fi
