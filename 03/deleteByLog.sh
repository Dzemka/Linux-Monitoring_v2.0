#!/bin/bash

function deleteByLog {
    read -rp "Enter name of log file: " fileName
    res=$( < "$fileName" awk '{print $1}')
    for fileToDelete in $res; do
        if [ "$fileToDelete" != "Start" ]; then
            rm -rf "$fileToDelete"
        fi
    done
}