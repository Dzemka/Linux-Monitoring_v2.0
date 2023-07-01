#!/bin/bash
if [ $# -ne 1 ]; then
  echo "The number of parameters must be 1."
fi

goaccess "$1" -o report.html --log-format=COMBINED

read -rp "Open the web report? Y(y)/N(n)" res

if [[ "${res^}" == "Y" ]]; then
  open report.html
fi
