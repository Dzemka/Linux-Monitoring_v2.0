#!/bin/bash
. ./checkParams.sh

start=$(date +"%s.%N")
timeStart=$(date +"%T")

check="$(checkParams $@)"

if [ -n "$check" ]; then
  echo -e "$check"
  exit
fi

dateStart=$(date +"%d%m%y")
fileLogName="result_$(date +"%d_%m_%Y_%H_%M_%S").log"
lengthFolderLetter=${#2} #Get length parameter 3

fileSize=${3//Mb/} #Cut out "Mb". Example: 100Mb -> 100
fileChars=$((fileSize * 1000000 / 2)) #Calculate count chars to put in files

lengthFileLetter=${#2} #Get length parameter 2
indexDot=`expr index $2 .` #Get dot index

if [ "$indexDot" -gt 1 ] ; then #Get the length before the point
  fileNameMaxIndex=$((indexDot - 1))
else
  fileNameMaxIndex=$lengthFileLetter
fi

for dirToFill in $(find /home/ -type d | grep -v -E " " | shuf -n$((RANDOM % 11))); do

  LD=${1:0:1} #Get first letter of directory name
  LF=${2:0:1} #Get first letter of filename
  nameDirArray[0]=$LD$LD$LD$LD #fill array first letters
  nameFileArray[0]=$LF$LF$LF$LF #fill array first letters

  countDirs=$((RANDOM % 101))

  for ((i = 0; i < "$countDirs"; i++)); do #Loop creating directories
    if [ "$(df -h | grep -E '/$' | awk '{printf("%d", $4)}')" -le 1 ]; then #If size partition "/" less or equal 1GB exit
      exit
    fi
    if [ "$i" -eq 0 ] ; then
      for (( j = 0; j < "$lengthFolderLetter"; j++ )); do
          nameDirArray[$j]+=${1:$j:1}
      done
    else
      selectedIndex=$((RANDOM % lengthFolderLetter))
      nameDirArray[$selectedIndex]+=${1:$selectedIndex:1}
    fi
    dirName="$dirToFill/$(IFS=; echo "${nameDirArray[*]}")_$dateStart"
    if [ -d "$dirName" ]; then #If folder exist, create new name
      i=$((i-1))
      continue
    fi

    mkdir "$dirName"
    echo "$(realpath "$dirName") $(date +"%d_%m_%Y_%H_%M_%S")" >> "$fileLogName"

  countFiles=$((RANDOM % 101))

    for (( j = 0; j < countFiles; j++ )); do
        if [ "$(df -h| grep -E '/$' | awk '{printf("%d", $4)}')" -le 1 ]; then #If size partition "/" less or equal 1GB exit
          exit
        fi
      if [ "$j" -eq 0 ]; then
        for (( k = 0; k < lengthFileLetter; k++ )); do
            nameFileArray[$k]=${2:$k:1}
        done
      else
        selectedIndex=$((RANDOM % fileNameMaxIndex))
        nameFileArray[$selectedIndex]+=${2:$selectedIndex:1}
      fi
      fileName="$(IFS=; echo "${nameFileArray[*]}")_$dateStart"
    yes | head -$fileChars > "$dirName/$fileName"
      echo "$(realpath "$dirName/$fileName") $(date +"%d_%m_%Y_%H_%M_%S") $3" >> "$fileLogName"
    done
  done

nameDirArray=()
done

end=$(date +"%s.%N")
timeEnd=$(date +"%T")
time="Start : $timeStart, end : $timeEnd, total : $(awk 'BEGIN { printf "%f\n", '$end' - '$start' }')"
echo "$time"
echo "$time" >> "$fileLogName"
