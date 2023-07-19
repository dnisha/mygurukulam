#!/bin/bash

CONNECTION_FILE='connection.txt'
DETAILED_CONNECTION_FILE='detailed_connection.txt'

store_connection_details() {
    
     echo "${SERVER_NAME}:${PEM_FILE}:${PORT}:${USER_NAME}:${HOST}" >> ${CONNECTION_FILE}

}

#server:file:port:user:ip