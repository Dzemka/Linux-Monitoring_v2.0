#!/bin/bash
if [ $# -lt 1 ]; then
  echo "The number of parameters must be greater than one."
  exit
fi

goaccess "$1" -o report.html --log-format=COMBINED