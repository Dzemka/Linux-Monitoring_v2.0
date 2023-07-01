#!/bin/bash
function checkParams() {
    if [ $# != "1" ]; then
      echo "The number of parameters must be 1."
    elif ! echo "$1" | grep -qE "^[1-4]{1,1}$"; then
      echo "Incorrect parameter"
    fi
}
