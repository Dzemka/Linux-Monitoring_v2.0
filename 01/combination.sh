#!/bin/bash

function printName {
    for ((x = 0; x < $size; x++)); do
        for ((v = 0; v < ${arrCopy[$x]}; v++)); do
            echo -n ${arrLetters[$x]}
        done
    done
    echo
}

function setToStart {
    numberMax=$((numberMax + 1))
    isAddCombination=1
    index=$((size - 1))
    lenArr=${#arrCopy}
    for ((i = 0; i < $lenArr; i++)); do
        arrCopy[$i]=1
    done
}

function printExtendedComb {
    for ((y = 0; y < $size; y++)); do
        if [[ arrCopy[$y] -eq $numberMax ]]; then
            printName
            break
        fi
    done
}

function getNewComb {
    if [[ $isAddCombination -eq 0 ]]; then
        name=$(printName)
    else
        name=$(printExtendedComb)
    fi
    arrCopy[$index]=$((${arrCopy[$index]} + 1))
    index=$(( index + 1 ))
    while [[ $index -le $((size - 1)) ]]; do
        arrCopy[$index]=1
        index=$((index + 1))
    done
    index=$((size - 1))
}

function getName {
    name=
    while [ ! $name ]; do
        if [[ ${arrCopy[$index]} -ne $numberMax ]]; then
                getNewComb
        else
            index=$(($index - 1))
        fi

        if [[ $index -eq -1 ]]; then
            name="$(printName)"
            setToStart
        fi
    done
}
