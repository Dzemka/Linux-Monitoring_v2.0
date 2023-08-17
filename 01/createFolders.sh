#!/bin/bash

function fillFolder {
  declare -i index=$indexFile
  declare -a arrCopy=("${combFileNames[@]}")
  declare -n arrLetters=fileLetters
  size=$lengthFileLetterWithoutExt
  isAddCombination=$isAddCombinationFile
  declare -i numberMax=numberMaxFile
  for (( countFilesCreated = 0; countFilesCreated <= $1; countFilesCreated++)); do
    if [[ $(df -Bg / | awk 'NR==2 {print $4}' | sed 's/G//') -le 1 ]]; then
      exit
    fi
    getName
    fileName=$folderName"/"$name$extFile"_$dateStart"
    yes | head -n$countChars > $fileName
  done
}

function createFolders {
    for ((countDirCreated = 0; countDirCreated != $2; countDirCreated++)); do
        if [[ $(df -Bg / | awk 'NR==2 {print $4}' | sed 's/G//') -le 1 ]]; then
            break
        fi
        declare -n index=indexFolder
        declare -n arrCopy=combFolderNames
        declare -n arrLetters=folderLetters
        size=$lengthFolderLetter
        isAddCombination=$isAddCombinationFolder
        declare -n numberMax=numberMaxFolder
        getName
        folderName=$1"/"$name"_$dateStart"
        if [[ -e $folderName  ]]; then
            countDirCreated=$((countDirCreated - 1))
            continue
        fi
        mkdir $folderName
        fillFolder $4
    done
}
