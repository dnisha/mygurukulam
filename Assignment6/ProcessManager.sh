#!/bin/bash
source ./ProcessManagerHelper.sh

OPERATION=""
PATH=""
ALIAS=""
PRIORITY=""
TEMPLATE_FILE=unit.template
FILE=myfile
DB_FILE=serviceDBFile

AWK="/usr/bin/awk"
TOUCH="/usr/bin/touch"
MV="/usr/bin/mv"
SUDO="/usr/bin/sudo"
SYSTEMCTL="/usr/bin/systemctl"
KILL="/usr/bin/kill"
CAT="/usr/bin/cat"
RENICE="/usr/bin/renice"

while getopts "o:s:a:p:" opt; do
  case $opt in
    o)
      OPERATION=$OPTARG
      ;;
    s)
      PATH=$OPTARG
      ;;
    a)
      ALIAS=$OPTARG
      ;;
    p)
      PRIORITY=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done



main () {
  SERVICE_FILE=$ALIAS".service"
    
    case ${OPERATION} in  
    "register")  

      register
        ;;  

    "start")  

      $SUDO $SYSTEMCTL start ${SERVICE_FILE}
        ;;
    
    "status")  

      echo "Status : "$($SYSTEMCTL status demo.service | $AWK '/Active/ {print $2$3}')
        ;;

    "kill")  

      PID=$( get_pid )
      $SUDO $KILL -9 ${PID}
        ;;   

    "priority")  

      set_priority
      $AWK '{print "Priority : "$18}' /proc/${PID}/stat
        ;;

    "list")  

        $CAT ${DB_FILE}
        ;;  

    "top")  

      top
        ;;
    esac
}

set_priority () {

  NICE=0

  if [ ${PRIORITY} == "low" ]; then
   
   NICE=18

  elif [ ${PRIORITY} == "med" ]; then

   NICE=1

  else

  NICE=-18

  fi

  PID=$( get_pid )
  $SUDO $RENICE -n ${NICE} -p ${PID}

}

top () {

  PID=$( get_pid )
  STATE=$($SYSTEMCTL status demo.service | $AWK '/Active/ {print $2$3}')
  PRIORITY=$($AWK '{print "Priority : "$18}' /proc/${PID}/stat)
  SCRIPT=$($CAT /proc/${PID}/comm)
  echo -e "alias : ${ALIAS} \nPID : ${PID} \nState : ${STATE} \nPriority : ${PRIORITY} \nScript : ${SCRIPT} "
}

get_pid () {
  echo $($SYSTEMCTL show --property MainPID --value ${SERVICE_FILE})
}

main ${OPERATION} ${PATH} ${ALIAS} ${PRIORITY}
