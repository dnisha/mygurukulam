#!/bin/bash

create_ami () {

read -p "Enter the new version to deploy : " newVersion
echo "Deploying version, $newVersion"

echo "Creating new ami.."

#change version
gsed -i "s/version/$newVersion/g" checkout-code.sh

INSTANCE_ID=$(aws ec2 run-instances --image-id "ami-0b8323d51e0d7eff5" \
--instance-type "t2.micro" --key-name "gone-servers" \
--subnet-id "subnet-09f911215ecffbfe7" \
--security-group-ids "sg-01c5e535d8683e4d7" \
--associate-public-ip-address \
--tag-specifications "ResourceType=instance,Tags=[{Key=\"instance\",Value=\"avenger$newVersion\"}]" \
--user-data file://checkout-code.sh \
--query "Instances[0].InstanceId" \
--output text)

echo "instance created with id: $INSTANCE_ID"

echo "Waiting for instance to be in running state $INSTANCE_ID"
aws ec2 wait instance-running --instance-ids $INSTANCE_ID
echo "Waiting for status check $INSTANCE_ID"
aws ec2 wait instance-status-ok --instance-ids $INSTANCE_ID

AMI_ID=$(aws ec2 create-image \
--instance-id $INSTANCE_ID \
--name "MyAMI-FromInstance" \
--description "AMI created from instance" \
--output text)

echo "got ami id as: $AMI_ID"

gsed -i "s/$newVersion/version/g" checkout-code.sh

STATUS="pending"

while [ "$STATUS" != "available" ]
do

STATUS=$(aws ec2 describe-images --image-ids $AMI_ID \
--query "Images[0].State" \
--output text)
    
echo "AMI status: $STATUS"
    
sleep 5

done

echo "$AMI_ID" 

echo "now creating launch template"
gsed -i "s/\"ImageId\": \".*\"/\"ImageId\": \"$AMI_ID\"/" launch-template.json
gsed -i "s/\"Value\": \".*\"/\"Value\": \"avenger$newVersion\"/" launch-template.json

aws ec2 create-launch-template --cli-input-json file://launch-template.json

aws ec2 terminate-instances --instance-ids $INSTANCE_ID

}

create_ami