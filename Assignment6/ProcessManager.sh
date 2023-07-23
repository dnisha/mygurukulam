#!/bin/bash


OPERATION=""
PATH=""
ALIAS=""
PRIORITY=""
TEMPLATE_FILE=unit.template
FILE=myfile

while getopts "o:s:a:p:" opt; do
  case $opt in
    o)
      echo "Option 'o' is set."
      OPERATION=$OPTARG
      ;;
    s)
      echo "Option 's' is set."
      PATH=$OPTARG
      ;;
    a)
      echo "Option 'a' is set."
      ALIAS=$OPTARG
      ;;
    p)
      echo "Option 'p' is set."
      PRIORITY=$OPTARG
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done

main () {
    
    case ${OPERATION} in  
    "register")  
        echo "register ${PATH} ${TEMPLATE_FILE}"

        sed -i 's/alias/deepak/g; s/path/bin/g' "${TEMPLATE_FILE}"
      
        ;;  

    "start")  
        echo "start"
        ;;
    
    "status")  
        echo "start"
        ;;

    "kill")  
        echo "start"
        ;;   

    "priority")  
        echo "start"
        ;;

    "list")  
        echo "list"
        ;;  
    esac
}


main ${OPERATION} ${PATH} ${ALIAS} ${PRIORITY}
echo "OPTION O=$OPERATION S=$PATH A=$ALIAS P=$PRIORITY"
#sed -e "s/alias/test/g" -e "s/path/'bin\/demo\'/g" template