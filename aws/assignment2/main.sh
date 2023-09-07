#!/bin/bash
#source ./rolling-deploy.sh
source ./recreate-deploy.sh

TARGET_GROUP_ARN="arn:aws:elasticloadbalancing:ap-south-1:313578065517:targetgroup/custom-app-tg/7e1bdb77409e0b9c"
#AMI="ami-0886910d55b5d025a"
SUBNET="subnet-04dffad7706297237"
SECURITY_GROUP="sg-09decdb19debd6a3a"
DEPLYOMENT_TYPE=$1

read -p "Enter the new version to deploy: " newVersion
echo "Deploying version, $newVersion"

read -p "Enter the old version to replace: " oldVersion
echo "Version to remove, $oldVersion"

read -p "Enter AMI ID: " AMI
echo "Using AMI, $AMI"


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