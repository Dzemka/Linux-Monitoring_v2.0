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
arrayMethods=(GET POST PUT PATCH DELETE)
arrayCodes=(200 201 400 401 403 404 500 501 502 503)
#RESPONSE CODES
#200 - SUCCESS
#201 - CREATED
#400 - BAD REQUEST
#401 - UNAUTHORIZED
#403 - FORBIDDEN
#404 - NOT FOUND
#500 - INTERNAL SERVER ERROR
#502 - BAD GATEWAY
#503 - SERVICE UNAVAILABLE

arrayAgents=("Mozilla/5.0 (platform; rv:geckoversion) Gecko/geckotrail Firefox/firefoxversion"
"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36"
"Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.106 Safari/537.36 OPR/38.0.2220.41"
"Mozilla/5.0 (iPhone; CPU iPhone OS 13_5_1 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.1.1 Mobile/15E148 Safari/604.1"
"Mozilla/5.0 (compatible; MSIE 9.0; Windows Phone OS 7.5; Trident/5.0; IEMobile/9.0)"
"Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36 Edg/91.0.864.59"
"Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
"Mozilla/5.0 (compatible; YandexAccessibilityBot/3.0; +http://yandex.com/bots)"
"curl/7.64.1"
"PostmanRuntime/7.26.5")

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
      startTime=$((startTime + 1))
    done
done
