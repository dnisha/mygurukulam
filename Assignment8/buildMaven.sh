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

        mvn clean test jacoco:report-aggregate -DdataFileFormat=html
        
      ;;
    "deploy")

        cp /target/Spring3HibernateApp.war /var/lib/tomcat7/webapps

      ;;
    *)
     "No such operation ..!"
     ;;
esac

}

static_code_analysis () {

    if [ ${STATIC_CODE} == "checkstyle" ]; then

    mvn clean compile checkstyle:checkstyle

    elif [ ${STATIC_CODE} == "findbugs" ]; then

    mvn clean compile findbugs:findbugs

    elif [ ${STATIC_CODE} == "pmd" ]; then
   
    mvn clean compile pmd:pmd

    fi

}

main ${OPERATION} ${STATIC_CODE} ${TEST_PLUGIN}