#!/bin/bash

for i in {1..2}; do

INSTANCE_ID=$(aws ec2 run-instances \
    --image-id "ami-0886910d55b5d025a" \
    --instance-type "t2.micro" \
    --key-name "server1" \
    --subnet-id subnet-0f1a64e0ec816a4a2 \
    --security-group-ids sg-004626cc12a4de3ce \
    --tag-specifications "ResourceType=instance,Tags=[{Key="instance",Value="avengerv2"}]" \
    --query "Instances[0].InstanceId" \
    --output text)

echo "New instance created: $INSTANCE_ID"

aws ec2 wait instance-running --instance-ids $INSTANCE_ID

aws elbv2 register-targets \
    --target-group-arn $TARGET_GROUP_ARN \
    --targets Id=$INSTANCE_ID

OLD_INSTANCE_ID=$(aws ec2 describe-instances \
    --filters "Name=tag:instance,Values=avengerv1" "Name=instance-state-name,Values=stopped" \
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