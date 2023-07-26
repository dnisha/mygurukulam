#!/bin/bash

OPERATION=""
STATIC_CODE=""
TEST_PLUGIN=""


while getopts "aids:t:" opt; do
  case $opt in
    a)
      OPERATION=generate_artifact
      ;;
    i)
      OPERATION=install
      ;;
    s)
      OPERATION=code_analysis
      STATIC_CODE=$OPTARG
      ;;
    t)
      OPERATION=unit_test
      TEST_PLUGIN=$OPTARG
      ;;

    d)
      OPERATION=deploy
      ;;
    \?)
      echo "Invalid option: -$OPTARG"
      ;;
  esac
done


main () {

    case ${OPERATION} in

    "generate_artifact")

        mvn package
     ;;
    "install")

        mvn install
      ;;
    "code_analysis")

        static_code_analysis ${STATIC_CODE}

      ;;
    "unit_test")

        mvn site -D${STATIC_CODE}.output=html
        
      ;;
    "deploy")

        cp /target/springboot-webFlux-TodoApp-0.0.1-SNAPSHOT.war /opt/tomcat/webapps/

      ;;
    *)
     "No such operation ..!"
     ;;
esac

}

static_code_analysis () {

    if [ ${STATIC_CODE} == "checkstyle" ]; then

    mvn clean site -Dspotbugs.skip=true -Dpmd.skip=true

    elif [ ${STATIC_CODE} == "spotbugs" ]; then

    mvn clean site -Dcheckstyle.skip=true -Dpmd.skip=true

    elif [ ${STATIC_CODE} == "pmd" ]; then
   
    mvn clean site -Dspotbugs.skip=true -Dcheckstyle.skip=true

    fi

}

main ${OPERATION} ${STATIC_CODE} ${TEST_PLUGIN}