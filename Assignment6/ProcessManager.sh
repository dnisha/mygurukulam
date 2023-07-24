#!/bin/bash


OPERATION=""
PATH=""
ALIAS=""
PRIORITY=""
TEMPLATE_FILE=unit.template
FILE=myfile

AWK="/usr/bin/awk"
TOUCH="/usr/bin/touch"
MV="/usr/bin/mv"
SUDO="/usr/bin/sudo"
SYSTEMCTL="/usr/bin/systemctl"
KILL="/usr/bin/kill"

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

      $TOUCH ${SERVICE_FILE}
      $AWK -v script_path="$PATH" -v script_alias="$ALIAS" '{gsub(/alias/, script_alias); gsub(/path/, script_path); print}' ${TEMPLATE_FILE} > ${SERVICE_FILE}
      $SUDO $MV ${SERVICE_FILE} "/usr/lib/systemd/system"
      $SUDO $SYSTEMCTL daemon-reload 
        ;;  

    "start")  

      $SUDO $SYSTEMCTL start ${SERVICE_FILE}
        ;;
    
    "status")  

      $SYSTEMCTL status ${SERVICE_FILE}
        ;;

    "kill")  

      PID=$($SYSTEMCTL show --property MainPID --value ${SERVICE_FILE})
      $SUDO $KILL -9 ${PID}
        ;;   

    "priority")  

      PID=$($SYSTEMCTL show --property MainPID --value ${SERVICE_FILE})
      $AWK '{print "Priority : "$18}' /proc/${PID}/stat
        ;;

    "list")  
        echo "list"
        ;;  
    esac
}


main ${OPERATION} ${PATH} ${ALIAS} ${PRIORITY}

echo "OPTION O=$OPERATION S=$PATH A=$ALIAS P=$PRIORITY"