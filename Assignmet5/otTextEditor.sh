#!/bin/bash

OPERATION=$1
FILE=$2

if [ ${OPERATION} == "addLineTop" ]; then
  
    LINE=$3
    sed -i "1 i ${LINE}" ${FILE}

elif [ ${OPERATION} == "addLineBottom" ]; then

    LINE=$3
    sed -i "$ a\\${LINE}" ${FILE}

elif [ ${OPERATION} == "addLineAt" ]; then

    LINE_NUMBER=$3
    LINE=$4
    sed -i "${LINE_NUMBER} a ${LINE}" ${FILE}

elif [ ${OPERATION} == "updateFirstWord" ]; then

    WORD1=$3
    WORD2=$4
    sed -i "0,/${WORD1}/s//${WORD2}/" ${FILE}

elif [ ${OPERATION} == "updateAllWords" ]; then

    WORD1=$3
    WORD2=$4
    sed -i "s/${WORD1}/${WORD2}/" ${FILE}

elif [ ${OPERATION} == "insertWord" ]; then

    WORD1=$3
    WORD2=$4
    WORD_TO_INSERT=$5
    sed -i "s/\(${WORD1}\) \(${WORD2}\)/\1 ${WORD_TO_INSERT} \2/" ${FILE}
   

elif [ ${OPERATION} == "deleteLine" ]; then

    LINE_NUMBER=$3
    
        if [ "$#" -eq 3 ]; then

            sed -i "${LINE_NUMBER}d" ${FILE}

        elif [ "$#" -eq 4 ]; then

            WORD=$4
            sed -i "${LINE_NUMBER}{/${WORD}/d;}" ${FILE}

        fi


fi

