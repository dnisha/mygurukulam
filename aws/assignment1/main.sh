#!/bin/bash

source ./rolling-deploy.sh
source ./recreate-deploy.sh

TARGET_GROUP_ARN="arn:aws:elasticloadbalancing:ap-south-1:063762586807:targetgroup/avenger-app-tg/da3947ebef66b07e"
AMI="ami-0886910d55b5d025a"
SUBNET="subnet-0f1a64e0ec816a4a2"
SECURITY_GROUP="sg-004626cc12a4de3ce"
DEPLYOMENT_TYPE=$1


main () {

case ${DEPLYOMENT_TYPE} in

    "recreate")

        echo "recreate deployment"
        recreate
     ;;

    "rolling")

        echo "rolling deployment"
        rolling
     ;;

    *)
        echo "No such operation ..!"
     ;;

esac

}

main