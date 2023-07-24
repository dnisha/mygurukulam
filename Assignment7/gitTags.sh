#!/bin/bash

OPERATION=$1
TAG_NAME=""

main () {

    if [ ${OPERATION} == "-t" ]; then

    create_tag 

    elif [ ${OPERATION} == "-l" ]; then

    list_tag ${TAG_NAME}

    elif [ ${OPERATION} == "-d" ]; then
    echo "delete"

    fi
}

create_tag () {
    git tag ${TAG_NAME}
}

list_tag () {
    git tag --list 
}

main ${OPERATION}