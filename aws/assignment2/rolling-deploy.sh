#!/bin/bash

rolling () {

echo "starting rolling deployment"
tempVersion=""

if [[ $newVersion == "v1" ]]; then
tempVersion="1"
else
tempVersion="2"
fi

aws autoscaling update-auto-scaling-group --auto-scaling-group-name Avenger-app-asg \
--launch-template "LaunchTemplateName=Avengerapp,Version=$tempVersion" \
--desired-capacity 5

read -p "Do you want to rollback : " rollBack
echo "Rollback : $rollBack"

if [[ $rollBack == "yes" ]]; then
    echo "rollingback..."
    tempVersion="1"
    aws autoscaling update-auto-scaling-group --auto-scaling-group-name Avenger-app-asg \
    --launch-template "LaunchTemplateName=Avengerapp,Version=$tempVersion" \
    --desired-capacity 5

    INSTANCE_IDS=$(aws ec2 describe-instances \
    --filters "Name=tag:instance,Values=avenger$newVersion" "Name=instance-state-name,Values=running" \
    --query "Reservations[].Instances[].InstanceId" \
    --output text)

    for INSTANCE_ID in $INSTANCE_IDS; do
    echo "Terminating Instance of ID: ${INSTANCE_ID}"
    aws ec2 terminate-instances --instance-ids $INSTANCE_ID
    aws ec2 wait instance-terminated --instance-ids $INSTANCE_ID
    done

else

    INSTANCE_IDS=$(aws ec2 describe-instances \
    --filters "Name=tag:instance,Values=avenger$oldVersion" "Name=instance-state-name,Values=running" \
    --query "Reservations[].Instances[].InstanceId" \
    --output text)

    for INSTANCE_ID in $INSTANCE_IDS; do
    echo "Terminating Instance of ID: ${INSTANCE_ID}"
    aws ec2 terminate-instances --instance-ids $INSTANCE_ID
    aws ec2 wait instance-terminated --instance-ids $INSTANCE_ID
    done

fi

aws autoscaling update-auto-scaling-group --auto-scaling-group-name Avenger-app-asg \
--desired-capacity 3 \
--launch-template "LaunchTemplateName=Avengerapp,Version=$tempVersion" 

echo "Rolling deployment complete."

}