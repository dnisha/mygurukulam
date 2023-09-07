#!/bin/bash

rolling () {

echo "starting rolling deployment"

aws autoscaling update-auto-scaling-group --auto-scaling-group-name Avenger-app-asg \
--launch-template "LaunchTemplateName=MyLaunchTemplate,Version=1" \
--desired-capacity 5 

INSTANCE_IDS=$(aws ec2 describe-instances \
    --filters "Name=tag:instance,Values=avenger$oldVersion" "Name=instance-state-name,Values=running" \
    --query "Reservations[].Instances[].InstanceId" \
    --output text)

for INSTANCE_ID in $INSTANCE_IDS; do
    echo "Terminating Instance of ID: ${INSTANCE_ID}"
    aws ec2 terminate-instances --instance-ids $INSTANCE_ID
    sleep 45
done

aws autoscaling update-auto-scaling-group --auto-scaling-group-name Avenger-app-asg \
--desired-capacity 3

echo "Rolling deployment complete."

}