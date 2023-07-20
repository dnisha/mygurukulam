#!/bin/bash

INPUT_FILE=""
FNAME=""
TOPIC=""
KEY=""
VALUE=""

for arg in "$@"; do

    if [[ "$arg" == *"="* ]]; then
        
        KEY=${arg%%=*}
        VALUE=${arg#*=}

        case "$KEY" in
            fname)
                FNAME="$VALUE"
                ;;
            topic)
                TOPIC="$VALUE"
                ;;
            *)
                exit 1
                ;;
        esac
    else
        INPUT_FILE="$arg"
    fi

done

sed -e "s/fname/${FNAME}/g" -e "s/topic/${TOPIC}/g" ${INPUT_FILE}

#refrance - https://stackoverflow.com/questions/13570327/how-to-delete-a-substring-using-shell-script
#https://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
