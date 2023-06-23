#!/bin/bash

function checkParams() {
    if [ $# -ne 6 ]
    then
      echo "The number of parameters must be 6.
Parameter 1 : path.
Parameter 2 : count of subfolders.
Parameter 3 : list of letters for folder names (max 7).
Parameter 4 : the number of files in each created folder.
Parameter 5 : list of letters used in the file name and extension (name - max 7, extension - max 3).
Parameter 6 : the size of the files (in kilobytes, but not more than 100)."
    elif [ ! -d "$1" ]; then
      echo "Invalid parameter 1 : path not found"
    elif [ ! "$(echo $2 | grep -E '^[1-9]{1,1}($|[0-9]+$)')" ]; then
        echo "Invalid parameter 2 : The parameter must consist of integers greater than 0"
    elif [ ! $(echo $3 | grep -E '^[a-zA-Z]{1,7}$') ]; then
        echo "Invalid parameter 3 : The parameter must consist of alphabetic characters (1-7 alphabetic word)"
    elif [ ! $(echo $4 | grep -E '^[1-9]{1,1}($|[0-9]+$)') ]; then
        echo "Invalid parameter 4 : The parameter must consist of integers greater than 0"
    elif [ ! $(echo $5 | grep -E '^[a-zA-Z]{1,7}($|[.]{1,1}[a-zA-Z]{1,3}$)') ] ; then
      echo
       echo "Invalid parameter 5 : The parameter must consist of alphabetic characters (1-7 alphabetic word, and optional for extension 1-3 alphabetic word"
    elif [ ! $(echo $6 | grep -E '^[1-9]{1,1}(kb$|[0-9]+kb$)') ] || [ $(echo $6 | sed 's/kb//') -gt 100 ]; then
        echo "Invalid parameter 6 : The parameter must consist of integers (1-100 in kb) ending in \"kb\""
    fi
}