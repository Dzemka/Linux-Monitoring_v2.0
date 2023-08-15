#!/bin/bash

function getDataCombFolder {
    indexFolder=$((lengthFolderLetter - 1))
    if [[ $lengthFolderLetter -lt 5 ]]; then
        numberMaxFolder=$((6 - $lengthFolderLetter))
        isAddCombinationFolder=1
    else
        numberMaxFolder=3
        isAddCombinationFolder=0
    fi
        for((i = 0; i < $lengthFolderLetter; i++)); do
            combFolderNames[i]=1
        done
}

function getDataCombFiles {
    indexFile=$((lengthFileLetterWithoutExt - 1))
    lengthFileLetterWithoutExt=${#fileLetters[@]}
    if [[ $lengthFileLetter -lt 5 ]]; then
        numberMaxFile=$((6 - $lengthFileLetter))
        isAddCombinationFile=1
    else
        numberMaxFile=3
        isAddCombinationFile=0
    fi
    for ((i = 0; i < $lengthFileLetterWithoutExt; i++)); do
        combFileNames[$i]=1
    done
}