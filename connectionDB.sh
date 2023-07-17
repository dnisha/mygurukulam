#!/bin/bash

CONNECTION_FILE='connection.txt'
DETAILED_CONNECTION_FILE='detailed_connection.txt'

store_connection_details() {
    echo "number of args $#"
    
    if [ $# -eq 2 ]; then
        echo "${1}" >> ${CONNECTION_FILE}
        echo "${1}: ssh ${USER_NAME_SERVER_IP}" >> ${DETAILED_CONNECTION_FILE}

    elif [ $# -eq 3 ]; then
        echo "${1}" >> ${CONNECTION_FILE}
        echo "${1}: ssh -p ${PORT} ${USER_NAME_SERVER_IP}" >> ${DETAILED_CONNECTION_FILE}
        
    elif [ $# -eq 4 ]; then
        echo "${1}" >> ${CONNECTION_FILE}
        echo "${1}: ssh -i ${PEM_FILE} -p ${PORT} ${USER_NAME_SERVER_IP}" >> ${DETAILED_CONNECTION_FILE}

    else
        echo "Invalid operration.."
    fi


}
