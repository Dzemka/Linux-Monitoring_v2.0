#!/bin/bash

function fillFolder {
  declare -i index=$indexFile
  declare -a arrCopy=("${combFileNames[@]}")
  declare -n arrLetters=fileLetters
  size=$lengthFileLetterWithoutExt
  isAddCombination=$isAddCombinationFile
  declare -i numberMax=numberMaxFile
  countFiles=$((RANDOM % 101))

  for (( countFilesCreated = 0; countFilesCreated < $countFiles; countFilesCreated++)); do
    if [[ $(df -Bg / | awk 'NR==2 {print $4}' | sed 's/G//') -le 1 ]]; then
      break
    fi
    getName
    fileName=$folderName"/"$name$extFile"_$dateStart"
    yes | head -n$countChars > $fileName
    echo "$fileName $(date +"%F %T") $fileSize""Mb" >> "$fileLogName"
  done
}

function createFolders {
    while [[ $(df -Bg / | awk 'NR==2 {print $4}' | sed 's/G//') -gt 1 ]] ; do
        getDataCombFolder
        countFolders=$((RANDOM % 101))
        dirToFill=${dirsToFill[$((RANDOM % countDirsToFill))]}
        for ((countDirCreated = 0; countDirCreated != $countFolders; countDirCreated++)); do
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
            folderName=$dirToFill"/"$name"_$dateStart"
            if [[ -e $folderName  ]]; then
                countDirCreated=$((countDirCreated - 1))
                continue
            fi
            mkdir $folderName
            # rpath=$(realpath $folderName)
            echo "$folderName $(date +"%F %T")" >> "$fileLogName"
            fillFolder
        done
    done
}