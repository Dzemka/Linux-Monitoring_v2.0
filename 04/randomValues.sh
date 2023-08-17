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
    echo "${arrayMethods[$((RANDOM % 5))]}"
}

function getRandomCode() {
    echo "${arrayCodes[$((RANDOM % 10))]}"
}

function getRandomAgent() {
    echo "${arrayAgents[$((RANDOM % 10))]}"
}
