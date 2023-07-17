create_directory () {
   DIRPATH=${1}/${2}

   mkdir ${DIRPATH}
 
   echo -e "${DATE} ${GREEN}[info]${NC} ${USER} ${DIRPATH} directory created.. " >> /tmp/dir_logs
}