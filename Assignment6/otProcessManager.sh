#!/bin/bash

OPERATION=$1

main () {

    case ${OPERATION} in  
    "topProcess")  

        LIMIT=${2}
        SORT_BY=${3}

        topProcess ${LIMIT} ${SORT_BY}
        ;;  

    "killLeastPriorityProcess")  
        killLeastPriorityProcess
        ;;

    "RunningDurationProcess")  

        PROCESS_ARG=${2}

        RunningDurationProcess ${PROCESS_ARG}
        ;;

    "listZoombieProcess")  

        listZoombieProcess
        ;;

    "listOrphanProcess")  

        listOrphanProcess
        ;; 

    "killProcess")  

        PROCESS_ARG=${2}

        killProcess ${PROCESS_ARG}
        ;;       

    "ListWaitingProcess") 

        ListWaitingProcess 
        ;;       

    esac 

}

topProcess () {

    LIMIT=${LIMIT}
    LIMIT=$((LIMIT+1))

if [ ${SORT_BY} == "cpu" ]; then
    SORT="cpu"

else
    SORT="mem"

fi

    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%${SORT} | head -n ${LIMIT}

}

killLeastPriorityProcess () {
    
    PID=$(ps -eo pid,ppid,pri,cmd,%mem,%cpu --sort=-nice | awk 'NR > 1 {print $1}' | head -n 1)
    kill -9 ${PID}
    echo "process of PID ${PID} is killed"

}

RunningDurationProcess () {

if [[ ${PROCESS_ARG} =~ ^[0-9]+$ ]]; then

    PROCESS_ID=${PROCESS_ARG}
else

    PROCESS_ID=$(pgrep -o ${PROCESS_ARG})
fi

    ps -eo pid,ppid,pri,etime,cmd | awk -v pid_or_name=${PROCESS_ID} 'NR > 1 {if($1 == pid_or_name ) print "PID :", $1 ,"DURATION :", $4}'

}

listZoombieProcess () {

    ps aux | awk '$8 ~ /^[Zz]/'

}

listOrphanProcess () {
    ps -al | awk '$5 == 1'
}

killProcess () {

if [[ ${PROCESS_ARG} =~ ^[0-9]+$ ]]; then

    PROCESS_ID=${PROCESS_ARG}
else

    PROCESS_ID=$(pgrep -o ${PROCESS_ARG})
fi

    kill -9 ${PROCESS_ID}

}

ListWaitingProcess () {

    ps -eo ppid,pid,user,stat,pcpu,comm | awk '/[D,S]/ {print}'

}

main ${OPERATION} $2 $3