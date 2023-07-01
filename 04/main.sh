#!/bin/bash

. randomValues.sh

if [ $# -ne 0 ]; then
  echo "program must execute without parameters"
  exit
fi

for (( i = 0; i < 5; i++ )); do
    dateFile[i]=$(shuf -n 1 -i 0-"$(date +"%s")")
    fileNames[i]="nginx_$(date +"%d_%m_%Y" -d @"${dateFile[i]}").log"
done

startTime=$(shuf -n1 -i 0-85400) #Get random time by count seconds in one day minus 1000 for fill all entry

for (( i = 0; i < 5; i++ )); do
    countEntry=$((RANDOM % 900 + 100))
    for (( j = 0; j < "$countEntry"; j++ )); do
      {
        echo -n "$(getRandomIp) - - "
        echo -n "[$(date +"%d/%b/%Y:" -d @"${dateFile[i]}")$(getTime "$startTime") +0000] "
        echo -n "\"$(getRandomMethod) /someFile HTTP/1.1\" "
        echo -n "$(getRandomCode)"
        echo -n " - \"http://$(getRandomIp)/\" "
        echo -n "\"$(getRandomAgent)\""
        echo
      } >> "${fileNames[i]}"
        startTime=$((startTime+1))
    done
done