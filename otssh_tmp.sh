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

case "$OPERATION" in

   "-a")

        USER_NAME_SERVER_IP=${7}@${5}
        USER_NAME=${7}
        SERVER_NAME=${3}
        PORT=${9}
        PEM_FILE=${11}

        if [ ${NUMBER_OF_ARG} -eq 7 ]; then
            ssh ${USER_NAME_SERVER_IP}
            echo -e "${RED}[ERROR]:${NC} ${SERVER_NAME} information is not available, please add server first" >> ${LOG_FILE}
            store_connection_details ${SERVER_NAME} ${USER_NAME_SERVER_IP}

        elif [ $NUMBER_OF_ARG -eq 9 ]; then
            ssh ${USER_NAME_SERVER_IP} -p ${PORT}
            echo -e "${RED}[ERROR]:${NC} ${SERVER_NAME} information is not available, please add server first" >> ${LOG_FILE}
            store_connection_details ${SERVER_NAME} ${USER_NAME_SERVER_IP} ${PORT}

        elif [ $NUMBER_OF_ARG -eq 11 ]; then
            ssh -p ${PORT} -i ${PEM_FILE} ${USER_NAME_SERVER_IP}  
            echo -e "${GREEN}Connecting${NC} to ${SERVER_NAME} on ${PORT} port as ${USER_NAME} via ${PEM_FILE} key" >> ${LOG_FILE}
            store_connection_details ${SERVER_NAME} ${USER_NAME_SERVER_IP} ${PORT} ${PEM_FILE}

        else
            echo "please provide all required information..!"
        fi
        ;;

    "-l")
        if [ ${NUMBER_OF_ARG} -eq 1 ]; then
            cat ${CONNECTION_FILE}

        elif [ $NUMBER_OF_ARG -eq 2 ]; then
            cat ${DETAILED_CONNECTION_FILE}

        else
            echo "incorrect arguments are passed..!"
        fi
    ;;

    "-r")
        SERVER_NAME=${2}

        if [ ${NUMBER_OF_ARG} -eq 1 ]; then
            awk "!/${SERVER_NAME}/" ${CONNECTION_FILE} > tmpfile && mv tmpfile ${CONNECTION_FILE} 

        else
            echo "incorrect arguments are passed..!"
        fi
    ;;

    "-m")

        SERVER_NAME=${3}
        USER_NAME_WITH_IP=${7}@${5}

        if [ ${NUMBER_OF_ARG} -eq 7 ]; then
            sed -i -e "s/\(${SERVER_NAME}: ssh \).*/\1${USER_NAME_WITH_IP}/" ${DETAILED_CONNECTION_FILE}

        elif [ $NUMBER_OF_ARG -eq 9 ]; then
            sed -i -e "s/\(${SERVER_NAME}: ssh -p 2022 \).*/\1${USER_NAME_WITH_IP}/" ${DETAILED_CONNECTION_FILE} 

        else
            echo "incorrect arguments are passed..!"
        fi

    ;;
esac

