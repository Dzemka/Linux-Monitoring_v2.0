#!/bin/bash

function getRandomIp() {
  for (( i = 0; i < 4; i++ )); do
#    val="$(echo | awk -v seed=$RANDOM 'BEGIN {srand(seed);} {printf("%03d\n", 256 * rand())}')"
    val=$((RANDOM % 256))
    echo -n "$val"
    if (( "$i" != 3)); then
      echo -n "."
    fi
  done
}

function getTime() {
    date -d @"$1" | awk '{print $5}'
}

function getRandomMethod() {
    arrayMethods=(GET POST PUT PATCH DELETE)
    echo "${arrayMethods[$((RANDOM % 5))]}"
}


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
function getRandomCode() {
    arrayCodes=(200 201 400 401 403 404 500 501 502 503)
    echo "${arrayCodes[$((RANDOM % 10))]}"
}

function getRandomAgent() {
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
    echo "${arrayAgents[$((RANDOM % 10))]}"
}