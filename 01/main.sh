#!/bin/bash
. ./checkParams.sh
. ./combination.sh
. ./createFolders.sh

check="$(checkParams $@)"

if [ ! -z "$check" ]; then
  echo -e "$check"
  exit
fi

#Init variables
dateStart=$(date +"%d%m%y")
countChars=$(echo ${6%kb} | awk '{print $1 * 500}') #Count of characters to fill the file, excluding line breaks


  #Set folder variables
lengthFolderLetter=${#3} #Get length parameter 3
folderLetters=($(echo $3 | grep -o .)) #Letter array for folders
indexFolder=$((lengthFolderLetter - 1))
if [[ $lengthFolderLetter -lt 4 ]]; then
  numberMaxFolder=$((5 - $lengthFolderLetter))
  isAddCombinationFolder=1
else
  numberMaxFolder=3
  isAddCombinationFolder=0
fi
for((i = 0; i < $lengthFolderLetter; i++)); do
  combFolderNames[i]=1
done

  #Set file variables
lengthFileLetter=${#5} #Get length parameter 5
fileNameLetters=${5%.*} #Get fileName without extension
fileLetters=($(echo $fileNameLetters | grep -o .)) #Get array letters
indexFile=$((lengthFileLetterWithoutExt - 1))
extFile=$(echo $5 | awk -F '.' '{print $2}')
if [[ -n "$extFile" ]]; then
  extFile=".$extFile"
fi
lengthFileLetterWithoutExt=${#fileLetters[@]}
if [[ $lengthFileLetter -lt 4 ]]; then
  numberMaxFile=$((5 - $lengthFileLetter))
  isAddCombinationFile=1
else
  numberMaxFile=3
  isAddCombinationFile=0
fi
for ((i = 0; i < $lengthFileLetterWithoutExt; i++)); do
  combFileNames[$i]=1
done

createFolders $@
