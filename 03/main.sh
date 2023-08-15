#!/bin/bash
. ./deleteByDate.sh
. ./deleteByLog.sh
. ./deleteByMask.sh

if [ $# -ne 1 ]; then
  echo "The number of parameters must be 1."
  exit
fi

if [ "$1" -eq 1 ]; then
  deleteByLog
elif [ "$1" -eq 2 ]; then
  deleteByDate
elif [ "$1" -eq 3 ]; then
  deleteByMask``
fi

