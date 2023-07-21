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

        RunningDurationProcess ${ID_OR_NAME}
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

  process_id=${PROCESS_ARG}
else

  process_id=$(pgrep -o ${PROCESS_ARG})
fi

ps -eo pid,ppid,pri,etime,cmd | awk -v pid_or_name=${process_id} 'NR > 1 {if($1 == pid_or_name ) print "PID :", $1 ,"DURATION :", $4}'

}

#ps -eo pid,ppid,pri,etime,cmd | awk -v pid=37 'NR > 1 {if($1 == pid || $5$6 == "") print "PID :", $1 ,"DURATION :", $4}'

main ${OPERATION} $2 $3