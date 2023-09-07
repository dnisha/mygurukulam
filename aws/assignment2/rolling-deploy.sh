#!/bin/bash

rolling () {

echo "got ami for rolling deployment as: $AMI"

for i in {1..2}; do

INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI \
    --instance-type "t2.micro" \
    --key-name "server1" \
    --subnet-id $SUBNET \
    --security-group-ids $SECURITY_GROUP \
    --tag-specifications "ResourceType=instance,Tags=[{Key="instance",Value="avenger$newVersion"}]" \
    --query "Instances[0].InstanceId" \
    --output text)

echo "New instance created: $INSTANCE_ID"

echo "Waiting for instance to be in running state $INSTANCE_ID"
aws ec2 wait instance-running --instance-ids $INSTANCE_ID

aws elbv2 register-targets \
    --target-group-arn $TARGET_GROUP_ARN \
    --targets Id=$INSTANCE_ID

OLD_INSTANCE_ID=$(aws ec2 describe-instances \
    --filters "Name=tag:instance,Values=avenger$oldVersion" "Name=instance-state-name,Values=running" \
    --query "Reservations[0].Instances[0].InstanceId" \
    --output text)

echo "Deregister loadbalancer old instance: $OLD_INSTANCE_ID"

aws elbv2 deregister-targets \
    --target-group-arn $TARGET_GROUP_ARN \
    --targets Id=$OLD_INSTANCE_ID

echo "Terminating old instance: $OLD_INSTANCE_ID"

aws ec2 terminate-instances --instance-ids $OLD_INSTANCE_ID

done

echo "Rolling deployment complete."

}