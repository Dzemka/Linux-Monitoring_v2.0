#!/bin/bash
. ./checkParams.sh
check="$(checkParams $@)"

if [ ! -z "$check" ]; then
  echo -e "$check"
  exit
fi

dateStart=$(date +"%d%m%y")
lengthFolderLetter=${#3} #Get length parameter 3
LD=${3:0:1} #Get first letter of directory name
LF=${5:0:1} #Get first letter of filename
nameDirArray[0]=$LD$LD$LD #fill array first letters
nameFileArray[0]=$LF$LF$LF #fill array first letters

fileSize=${6//kb/} #Cut out "kb". Example: 100kb -> 100
fileChars=$((fileSize * 1000 / 2)) #Calculate count chars to put in files

lengthFileLetter=${#5} #Get length parameter 5
indexDot=`expr index $5 .` #Get dot index

if [ "$indexDot" -gt 1 ] ; then #Get the length before the point
  fileNameMaxIndex=$((indexDot - 1))
else
  fileNameMaxIndex=$lengthFileLetter
fi

for ((i = 0; i < $2; i++)); do #Loop creating directories
  if [ "$(df -h | grep -E '/$' | awk '{printf("%d", $4)}')" -le 1 ]; then #If size partition "/" less or equal 1GB exit
    exit
  fi
  if [ "$i" -eq 0 ] ; then
    for (( j = 0; j < "$lengthFolderLetter"; j++ )); do
        nameDirArray[$j]+=${3:$j:1}
    done
  else
    selectedIndex=$((RANDOM % lengthFolderLetter))
    nameDirArray[$selectedIndex]+=${3:$selectedIndex:1}
  fi
  dirName="$1/$(IFS=; echo "${nameDirArray[*]}")_$dateStart"
  if [ -d "$dirName" ]; then #If folder exist, create new name
    i=$((i-1))
    continue
  fi

  mkdir "$dirName"

  for (( j = 0; j < $4; j++ )); do
      if [ "$(df -h | grep -E '/$' | awk '{printf("%d", $4)}')" -le 1 ]; then #If size partition "/" less or equal 1GB exit
        exit
      fi
    if [ "$j" -eq 0 ]; then
      for (( k = 0; k < lengthFileLetter; k++ )); do
          nameFileArray[$k]=${5:$k:1}
      done
    else
      selectedIndex=$((RANDOM % fileNameMaxIndex))
      nameFileArray[$selectedIndex]+=${5:$selectedIndex:1}
    fi
    fileName="$(IFS=; echo "${nameFileArray[*]}")_$dateStart"
  yes | head -$fileChars > "$dirName/$fileName"
  done
done
