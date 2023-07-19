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



<<COMMENT1

echo "fname=sandeep" | awk -F= '{ print $2}'
sed -e 's/$1/deepak/g' -e 's/$2/linux/g' trainer.template 
COMMENT1