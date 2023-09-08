#!/bin/bash
launch_template_name="Avengerapp"
result=$(aws ec2 describe-launch-templates --launch-template-names "$launch_template_name" --query "LaunchTemplates[0].LatestVersionNumber")

createTemplate () {
#read -p "Enter the new version to deploy : " newVersion
#echo "Deploying version, $newVersion"

#read -p "Enter the ami to deploy : " AMI_ID
#echo "Deploying version, $AMI_ID"

gsed -i "s/\"Value\": \".*\"/\"Value\": \"avenger$newVersion\"/" launch-template.json
gsed -i "s/\"ImageId\": \".*\"/\"ImageId\": \"$AMI_ID\"/" launch-template.json


if [[ -z "$result" ]]; then
    echo "Launch template '$launch_template_name' does not exist."
    aws ec2 create-launch-template --cli-input-json file://launch-template.json
elif [[ $result -eq 1 ]] && [[ $newVersion == "v2" ]]; then
    echo "Launch template '$launch_template_name' exists."
    aws ec2 create-launch-template-version \
    --launch-template-name "Avengerapp" \
    --version-description "Second version of Avengerapp" \
    --cli-input-json file://launch-template.json \
    --source-version 1

fi

}




