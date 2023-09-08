#!/bin/bash
source ./rolling-deploy.sh
source ./create-launch-template.sh

TARGET_GROUP_ARN="arn:aws:elasticloadbalancing:ap-south-1:313578065517:targetgroup/custom-app-tg/7e1bdb77409e0b9c"
SUBNET="subnet-04dffad7706297237"
SECURITY_GROUP="sg-09decdb19debd6a3a"
DEPLYOMENT_TYPE=$1

read -p "Enter the old version to replace: " oldVersion
echo "Version to remove, $oldVersion"

read -p "Enter the new version to deploy : " newVersion
echo "Deploying version, $newVersion"

read -p "Enter the ami to deploy : " AMI_ID
echo "Deploying version, $AMI_ID"

createTemplate

main () {

case ${DEPLYOMENT_TYPE} in

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