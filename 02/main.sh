#!/bin/bash
. ./checkParams.sh
. ./createFolders.sh
. ./combination.sh
. ./getDataComb.sh

check="$(checkParams $@)"

if [ -n "$check" ]; then
  echo -e "$check"
  exit
fi

#Init variables
start=$(date +"%s.%N")
timeStart=$(date +"%T")
dateStart=$(date +"%d%m%y")
fileSize=${3%Mb}
countChars=$((fileSize * 500000))
fileLogName="result_$(date +"%d_%m_%Y_%H_%M_%S").log"
dirsToFill=( $(find /home -type d) )
countDirsToFill=${#dirsToFill[@]}

  #Set folder variables
lengthFolderLetter=${#1}
folderLetters=( $(echo $1 | grep -o .) )

  #Set file variables
lengthFileLetter=${#2}
fileNameLetters=${2%.*}
fileLetters=( $(echo $fileNameLetters | grep -o .) )
extFile=$(echo $2 | awk -F '.' '{print $2}')
if [[ -n "$extFile" ]]; then
  extFile=".$extFile"
fi
getDataCombFiles

createFolders $@
end=$(date +"%s.%N")
timeEnd=$(date +"%T")
time="Start : $timeStart, end : $timeEnd, total : $(awk 'BEGIN { printf "%.2f\n", '$end' - '$start' }')s"
echo "$time"
echo "$time" >> "$fileLogName"
