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
      echo "Option 'a' is set."
      flag_a=true
      ;;
    n)
      echo "Option 'n' is set."
      n=$OPTARG
      ;;
    h)
      echo "Option 'h' is set."
      h=$OPTARG
      ;;
    u)
      echo "Option 'u' is set."
      u=$OPTARG
      ;;
    p)
      echo "Option 'p' is set."
      p=$OPTARG
      ;;
    l)
      echo "Option 'l' is set."
      flag_l=true
      ;;
    d)
      echo "Option 'd' is set."
      flag_d=true
      ;;
    m)
      echo "Option 'm' is set."
      flag_m=true
      ;;
    r)
      echo "Option 'r' is set."
      flag_r=true
      r=$OPTARG
      ;;
    i)
      echo "Option 'i' is set."
      i=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done 2>/dev/null

USER_NAME_SERVER_IP=${u}@${h}
USER_NAME=${u}
SERVER_NAME=${n}
PORT=${p}
PEM_FILE=${i}
SERVER_TO_REMOVE=${r}

if $flag_a; then
    if [ $flag_a ] && [ ! -z {$n} ] && [ ! -z ${h} ] && [ ! -z ${u} ] && [ -z ${p} ] && [ -z ${i} ]; then
        ssh ${USER_NAME_SERVER_IP}
        echo -e "${RED}[ERROR]:${NC} ${SERVER_NAME} information is not available, please add server first" >> ${LOG_FILE}
        store_connection_details ${SERVER_NAME} ${USER_NAME_SERVER_IP}
    
    elif [ $flag_a ] && [ ! -z {$n} ] && [ ! -z ${h} ] && [ ! -z ${u} ] && [ ! -z ${p} ] && [ -z ${i} ]; then
        ssh ${USER_NAME_SERVER_IP} -p ${PORT}
        echo -e "${RED}[ERROR]:${NC} ${SERVER_NAME} information is not available, please add server first" >> ${LOG_FILE}
        store_connection_details ${SERVER_NAME} ${USER_NAME_SERVER_IP} ${PORT}

    elif [ $flag_a ] && [ ! -z {$n} ] && [ ! -z ${h} ] && [ ! -z ${u} ] && [ ! -z ${p} ] && [ ! -z ${i} ]; then
        ssh -p ${PORT} -i ${PEM_FILE} ${USER_NAME_SERVER_IP}  
        echo -e "${GREEN}Connecting${NC} to ${SERVER_NAME} on ${PORT} port as ${USER_NAME} via ${PEM_FILE} key" >> ${LOG_FILE}
        store_connection_details ${SERVER_NAME} ${USER_NAME_SERVER_IP} ${PORT} ${PEM_FILE}
    fi
fi

if $flag_l; then

    if [ ${NUMBER_OF_ARG} -eq 1 ]; then
        cat ${CONNECTION_FILE}
    elif [ flag_d ]; then
        cat ${DETAILED_CONNECTION_FILE}
    fi
fi

if $flag_m; then
    if [ ! -z {$n} ] && [ ! -z ${h} ] && [ ! -z ${u} ] && [ -z ${p} ]; then
        sed -i -e "s/\(${SERVER_NAME}: ssh \).*/\1${USER_NAME_SERVER_IP}/" ${DETAILED_CONNECTION_FILE}

    elif [ ! -z {$n} ] && [ ! -z ${h} ] && [ ! -z ${u} ] && [ ! -z ${p} ]; then
        sed -i -e "s/\(${SERVER_NAME}: ssh -p 2022 \).*/\1${USER_NAME_SERVER_IP}/" ${DETAILED_CONNECTION_FILE} 

    else
        echo "incorrect arguments are passed..!"
    fi

fi

if $flag_r; then
    if [ ${NUMBER_OF_ARG} -eq 2 ]; then
        awk "!/${SERVER_TO_REMOVE}/" ${CONNECTION_FILE} > tmpfile && mv tmpfile ${CONNECTION_FILE} 
   
    else
        echo "incorrect arguments are passed..!"
    fi
fi

