#!/bin/sh

OPERATION=${1}
TEAM_FILE='Team.txt'
USER_FILE='User.txt'

case "$OPERATION" in

        "addTeam")

                GROUP_NAME=${2}
                sudo addgroup ${GROUP_NAME}
                echo ${GROUP_NAME} >> ${TEAM_FILE}
                ;;

        "addUser")

                USER_NAME=${2}
                GROUP_NAME=${3}
                sudo useradd -s /bin/bash -m -d /home/${USER_NAME} -G ${GROUP_NAME} -p '$1$/r8M5lvL$4Zy93Uu1xrB5RRKZ9a.0z.' ${USER_NAME}
                sudo chmod 751 /home/${USER_NAME}
                echo ${USER_NAME} >> ${USER_FILE}
                ;;

        "delTeam")

                GROUP_NAME=${2}
                sudo groupdel ${GROUP_NAME}
                awk "!/${GROUP_NAME}/" ${TEAM_FILE} > tmpfile && mv tmpfile ${TEAM_FILE}
                ;;

        "delUser")

                USER_NAME=${2}
                sudo deluser ${USER_NAME}
                awk "!/${USER_NAME}/" ${USER_FILE} > tmpfile && mv tmpfile ${USER_FILE}
                ;;

        "changePasswd")

                USER_NAME=${2}
                sudo passwd ${USER_NAME}
                ;;

        "changeShell")

                USER_NAME=${2}
                USER_SHELL=${3}
                sudo usermod -s ${USER_SHELL} ${USER_NAME}
                ;;

        "ls")

                LIST_ENTITY=${2}
                sudo cat ${LIST_ENTITY}.txt

esac
