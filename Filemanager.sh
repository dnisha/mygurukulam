#!/bin/sh

source ./Makedirectory.sh

OPERATION=${1}
DATE=$(date)
USER=$(whoami)
RED='\033[0;31m'
NC='\033[0m' 
GREEN='\033[0;32m'

case "$OPERATION" in
   "addDir")

   DIRPATH=${2}/${3}

   mkdir ${DIRPATH}
 
   echo -e "${DATE} ${GREEN}[info]${NC} ${USER} ${DIRPATH} directory created.. " >> /tmp/dir_logs
   ;;

   "listFiles")

   DIRPATH=${2}

   cd ${DIRPATH}
   ls -d -p * | grep -v /

   ;;

   "listDirs")

   DIRPATH=${2}

   if [$# -eq 1]
   then
         if [ -f ${DIRPATH} ] 
         then
         echo "Error: cannot apply list operation on file ${DIRPATH}"
         else

            if [ -d ${DIRPATH} ] 
            then
            cd ${DIRPATH}
            ls -d */
            else
            echo "Error: directory ${DIRPATH} didnot exist"
            fi
      
         fi
   else
         echo "Error: please provide directory path!!"
   fi

   ;;

   "listAll")

   DIRPATH=${2}

   cd ${DIRPATH}
   ls

   ;;

   "deleteDir")

   PARENT_PATH=${2}
   DIRECTORY=${3}

   rm -rf ${PARENT_PATH}/${DIRECTORY}

   ;;

   "addFile")

   PARENT_PATH=${2}
   FILE_NAME=${3}
   CONTENT=${4}

   if [ $# -eq 4 ]
   then

   cd ${PARENT_PATH}
   touch ${FILE_NAME}
   echo ${CONTENT} > ${FILE_NAME}

   fi
	cd ${PARENT_PATH}
	touch ${FILE_NAME}
   ;;

   "addContentToFile")

   PARENT_PATH=${2}
   FILE_NAME=${3}
   CONTENT=${4}

   if [ ! -d ${PARENT_PATH} ]
   then

   mkdir -p ${PARENT_PATH}
   fi
       
   cd ${PARENT_PATH}
   touch ${FILE_NAME}
   echo ${CONTENT} >> ${FILE_NAME}

   ;;

   "addContentToFileBegining")

   PARENT_PATH=${2}
   FILE_NAME=${3}
   CONTENT=${4}

   cd ${PARENT_PATH}
   echo ${CONTENT} | cat - ${FILE_NAME} > temp && mv temp ${FILE_NAME}

   ;;

   "showFileBeginingContent")

   PARENT_PATH=${2}
   FILE_NAME=${3}
   NO_OF_LINES=${4}

   cd ${PARENT_PATH}
   head -${NO_OF_LINES} ${FILE_NAME}

   ;;

   "showFileEndContent")

   PARENT_PATH=${2}
   FILE_NAME=${3}
   NO_OF_LINES=${4}

   cd ${PARENT_PATH}
   tail -${NO_OF_LINES} ${FILE_NAME}

   ;;

   "showFileContentAtLine")

   PARENT_PATH=${2}
   FILE_NAME=${3}
   NO_OF_LINES=${4}

   cd ${PARENT_PATH}
   head -${NO_OF_LINES} ${FILE_NAME} | tail -1

   ;;

   "showFileContentForLineRange")

   PARENT_PATH=${2}
   FILE_NAME=${3}
   START_LINES=${4}
   END_LINE=${5}

   cd ${PARENT_PATH}
   head -n ${END_LINE} ${FILE_NAME} | tail -n +${START_LINES}

   ;;

   "moveFile")
  
   SOURCE=${2}
   DESTINATION=${3}

   mv ${SOURCE} ${DESTINATION}

   ;;

   "copyFile")

   SOURCE=${2}
   DESTINATION=${3}

   cp ${SOURCE} ${DESTINATION}

   ;;

   "clearFileContent")

   PARENT_PATH=${2}
   FILE_NAME=${3}

   cd ${PARENT_PATH}
   truncate -s 0 ${FILE_NAME}

   ;;

   "deleteFile")

   PARENT_PATH=${2}
   FILE_NAME=${3}

   cd ${PARENT_PATH}
   rm -rf ${FILE_NAME} 

 esac
