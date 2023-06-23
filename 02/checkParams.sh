#!/bin/bash

function checkParams() {
    if [ $# -ne 3 ]; then
      echo "The number of parameters must be 6.
Parameter 1 : list of letters for folder names (max 7).
Parameter 2 : list of letters used in the file name and extension (name - max 7, extension - max 3).
Parameter 3 : the size of the files (in megabytes, but not more than 100)."
    elif [ ! $(echo $1 | grep -E '^[a-zA-Z]{1,7}$') ]; then
        echo "Invalid parameter 1 : The parameter must consist of alphabetic characters (1-7 alphabetic word)"
    elif [ ! $(echo $2 | grep -E '^[a-zA-Z]{1,7}($|[.]{1,1}[a-zA-Z]{1,3}$)') ]; then
      echo
       echo "Invalid parameter 2 : The parameter must consist of alphabetic characters (1-7 alphabetic word, and optional for extension 1-3 alphabetic word"
    elif [ ! $(echo $3 | grep -E '^[1-9]{1,1}(Mb$|[0-9]+Mb$)') ] || [ $(echo $3 | sed 's/Mb//') -gt 100 ]; then
        echo "Invalid parameter 3 : The parameter must consist of integers (1-100 in Mb) ending in \"Mb\""
    fi
}