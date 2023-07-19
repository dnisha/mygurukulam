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

if [ $1 == "-d" ]|| [ $1 == "-l" ]; then
  while getopts "ld" opt; do
  case $opt in
    l)
      flag_l=true
      ;;
    d)
      flag_d=true
      ;;
  esac
  done

fi


if [ $1 != "-d" ]|| [ $1 != "-l" ]; then
while getopts "an:h:u:p:mn:r:i:" opt; do
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
    #\?)
      #echo "Invalid option: -$OPTARG"
      #;;
  esac
done 2>/dev/null
fi

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
        echo -e "${GREEN}[INFO]:${NC} Connecting to ${SERVER_NAME} on ${PORT} port as ${USER_NAME} via ${PEM_FILE} key" | tee -a ${LOG_FILE}
        store_connection_details ${SERVER_NAME} ${USER_NAME} ${HOST} ${PORT} ${PEM_FILE}
    fi
fi

if [ ${flag_a} = false ] && [ ${flag_l} = true ] && [ ${flag_m} = false ] && [ ${flag_r} = false ]; then

    if [ ${flag_l} = true ] && [ ${flag_d} = false ]; then
    
        awk -F: '{print $1}' ${CONNECTION_FILE}

    elif [ ${flag_l} = true ] && [ ${flag_d} = true ]; then
    
        awk -F: '{if(length($2) == 0 && length($3) == 0) print $1": ssh "$4"@"$5" "; else if(length($2) == 0) print $1": ssh -p " $3 " "$4"@"$5" "; else print $1": ssh -i " $2 " -p " $3 " "$4"@"$5""}' ${CONNECTION_FILE}

    fi
else
    echo "Invalid option: ${2}"
fi


if [ ${flag_a} = false ] && [ ${flag_l} = false ] && [ ${flag_m} = true ] && [ ${flag_r} = false ]; then

    TEMP_FILE="temp_file.txt"

    if [ ! -z {$n} ] && [ ! -z ${h} ] && [ ! -z ${u} ] && [ -z ${p} ] && [ -z ${i} ]; then
        awk -v server_name=${SERVER_NAME} -v new_ip_address=${HOST} -v new_user=${USER_NAME} -F: '{ if (($1 == server_name && length($5) != 0 ) || ($1 == server_name && length($4) != 0)) { $5 = new_ip_address ; $4 = new_user } ; print $1 ":" $2 ":" $3 ":" $4 ":" $5 }' ${CONNECTION_FILE} > ${TEMP_FILE}
        mv ${TEMP_FILE} ${CONNECTION_FILE}

    elif [ ! -z {$n} ] && [ ! -z ${h} ] && [ ! -z ${u} ] && [ ! -z ${p} ] && [ -z ${i} ]; then
        awk -v server_name=${SERVER_NAME} -v new_ip_address=${HOST} -v new_user=${USER_NAME} -v new_port=${PORT} -F: '{ if (($1 == server_name && length($5) != 0 ) || ($1 == server_name && length($4) != 0) || ($1 == server_name && length($3) != 0) ) { $5 = new_ip_address ; $4 = new_user ; $3 =  new_port } ; print $1 ":" $2 ":" $3 ":" $4 ":" $5 }' ${CONNECTION_FILE} > ${TEMP_FILE}
        mv ${TEMP_FILE} ${CONNECTION_FILE}

    elif [ ! -z {$n} ] && [ ! -z ${h} ] && [ ! -z ${u} ] && [ ! -z ${p} ] && [ ! -z ${i} ]; then
        awk -v server_name=${SERVER_NAME} -v new_ip_address=${HOST} -v new_user=${USER_NAME} -v new_port=${PORT} -v new_file=${PEM_FILE} -F: '{ if (($1 == server_name && length($5) != 0 ) || ($1 == server_name && length($4) != 0) || ($1 == server_name && length($3) != 0) || ($1 == server_name && length($2) != 0) ) { $5 = new_ip_address ; $4 = new_user ; $3 =  new_port ; $2 = new_file } ; print $1 ":" $2 ":" $3 ":" $4 ":" $5 }' ${CONNECTION_FILE} > ${TEMP_FILE}
        mv ${TEMP_FILE} ${CONNECTION_FILE}

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

