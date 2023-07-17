#!/bin/bash

source ./connectionDB.sh

CONNECTION_FILE='connection.txt'
DETAILED_CONNECTION_FILE='detailed_connection.txt'
OPERATION=${1}
NUMBER_OF_ARG=$#
LOG_FILE='/tmp/ssh_log'
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' 

flag_a=false
flag_l=false
flag_m=false
flag_r=false
flag_d=false

while getopts "an:h:u:p:ld:mn:r:i:" opt; do
  case $opt in
    a)
      flag_a=true
      ;;
    n)
      n=$OPTARG
      ;;
    h)
      h=$OPTARG
      ;;
    u)
      u=$OPTARG
      ;;
    p)
      p=$OPTARG
      ;;
    l)
      flag_l=true
      ;;
    d)
      flag_d=true
      ;;
    m)
      flag_m=true
      ;;
    r)
      flag_r=true
      r=$OPTARG
      ;;
    i)
      i=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done 2>/dev/null

USER_NAME_SERVER_IP=${u}@${h}
HOST=${h}
USER_NAME=${u}
SERVER_NAME=${n}
PORT=${p}
PEM_FILE=${i}
SERVER_TO_REMOVE=${r}

if  [ ${flag_a} = true ] && [ ${flag_l} = false ] && [ ${flag_m} = false ] && [ ${flag_r} = false ]; then

    if [ $flag_a ] && [ ! -z {$n} ] && [ ! -z ${h} ] && [ ! -z ${u} ] && [ -z ${p} ] && [ -z ${i} ]; then
        ssh ${USER_NAME_SERVER_IP} 2>/dev/null
        echo -e "${RED}[ERROR]:${NC} ${SERVER_NAME} information is not available, please add server first" | tee -a ${LOG_FILE}
        store_connection_details ${SERVER_NAME} ${USER_NAME} ${HOST}
    
    elif [ $flag_a ] && [ ! -z {$n} ] && [ ! -z ${h} ] && [ ! -z ${u} ] && [ ! -z ${p} ] && [ -z ${i} ]; then
        ssh ${USER_NAME_SERVER_IP} -p ${PORT} 2>/dev/null
        echo -e "${RED}[ERROR]:${NC} ${SERVER_NAME} information is not available, please add server first" | tee -a ${LOG_FILE}
        store_connection_details ${SERVER_NAME} ${USER_NAME} ${HOST} ${PORT}

    elif [ $flag_a ] && [ ! -z {$n} ] && [ ! -z ${h} ] && [ ! -z ${u} ] && [ ! -z ${p} ] && [ ! -z ${i} ]; then
        ssh -p ${PORT} -i ${PEM_FILE} ${USER_NAME_SERVER_IP} 2>/dev/null
        echo -e "${GREEN}Connecting${NC} to ${SERVER_NAME} on ${PORT} port as ${USER_NAME} via ${PEM_FILE} key" | tee -a ${LOG_FILE}
        store_connection_details ${SERVER_NAME} ${USER_NAME} ${HOST} ${PORT} ${PEM_FILE}
    fi
fi

if [ ${flag_a} = false ] && [ ${flag_l} = true ] && [ ${flag_m} = false ] && [ ${flag_r} = false ]; then

    if [ ${NUMBER_OF_ARG} -eq 1 ]; then
        awk -F: '{print $1}' ${CONNECTION_FILE}
    elif [ flag_d ]; then
        awk -F: '{if(length($2) == 0 && length($3) == 0) print $1": ssh "$4"@"$5" "; else if(length($2) == 0) print $1": ssh -p " $3 " "$4"@"$5" "; else print $1": ssh -i " $2 " -p " $3 " "$4"@"$5""}' ${CONNECTION_FILE}

    fi
fi

if [ ${flag_a} = false ] && [ ${flag_l} = false ] && [ ${flag_m} = true ] && [ ${flag_r} = false ]; then

    if [ ! -z {$n} ] && [ ! -z ${h} ] && [ ! -z ${u} ] && [ -z ${p} ]; then
        sed -i -e "s/\(${SERVER_NAME}: ssh \).*/\1${USER_NAME_SERVER_IP}/" ${DETAILED_CONNECTION_FILE}

    elif [ ! -z {$n} ] && [ ! -z ${h} ] && [ ! -z ${u} ] && [ ! -z ${p} ]; then
        sed -i -e "s/\(${SERVER_NAME}: ssh -p 2022 \).*/\1${USER_NAME_SERVER_IP}/" ${DETAILED_CONNECTION_FILE} 

    else
        echo "incorrect arguments are passed..!"
    fi

fi

if [ ${flag_a} = false ] && [ ${flag_l} = false ] && [ ${flag_m} = false ] && [ ${flag_r} = true ]; then

    if [ ${NUMBER_OF_ARG} -eq 2 ]; then
        awk "!/${SERVER_TO_REMOVE}/" ${CONNECTION_FILE} > tmpfile && mv tmpfile ${CONNECTION_FILE} 
   
    else
        echo "incorrect arguments are passed..!"
    fi
fi


#awk -F: '{print "ssh -i " $2 " -p " $3 " "$4"@"$5}' ${CONNECTION_FILE}