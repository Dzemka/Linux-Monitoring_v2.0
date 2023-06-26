#!/bin/bash

function isCorrect() {
    if [ $# -ne 1 ]; then
      echo "The number of parameters must be 1."
    fi
}