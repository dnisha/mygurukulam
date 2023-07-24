#!/bin/bash

OPERATION=$1
TAG_NAME=""

main () {

    if [ ${OPERATION} == "-t" ]; then

    TAG_NAME=${2}
    create_tag 

    elif [ ${OPERATION} == "-l" ]; then

    list_tag ${TAG_NAME}

    elif [ ${OPERATION} == "-d" ]; then
    TAG_NAME=${2}
    delete_tag ${TAG_NAME}

    fi
}

create_tag () {
    git tag ${TAG_NAME}
}

list_tag () {
    git tag --list 
}
delete_tag () {
    git tag -d ${TAG_NAME}
}
main ${OPERATION} $2