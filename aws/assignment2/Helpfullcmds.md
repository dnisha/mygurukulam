pip install gunicorn
pip install flask
gunicorn -b 0.0.0.0:8000 app:app 

python app.py



aws ec2 run-instances --image-id "ami-0b8323d51e0d7eff5" \
--instance-type "t2.micro" --key-name "gone-servers" \
--subnet-id "subnet-09f911215ecffbfe7" \
--security-group-ids "sg-01c5e535d8683e4d7" \
--associate-public-ip-address \
--tag-specifications "ResourceType=instance,Tags=[{Key=\"instance\",Value=\"avengerv1\"}]" \
--user-data file://checkout-code.sh
--query "Instances[0].InstanceId" \
--output text

aws autoscaling create-auto-scaling-group \
--auto-scaling-group-name Avenger-app-asg \
--launch-template "LaunchTemplateName=Avengerapp,Version=1" \
--min-size 2 \
--max-size 5 \
--desired-capacity 3 \
--vpc-zone-identifier "subnet-04dffad7706297237","subnet-05b73760f13f91dca" \
--availability-zones "ap-south-1a" "ap-south-1b" \
--default-cooldown 70 \
--health-check-type EC2 \
--health-check-grace-period 60 \
--tags "Key=Name,Value=MyAutoScalingGroup,PropagateAtLaunch=true"

aws autoscaling attach-load-balancer-target-groups \
--auto-scaling-group-name Avenger-app-asg \
--target-group-arns arn:aws:elasticloadbalancing:ap-south-1:313578065517:targetgroup/custom-app-tg/7e1bdb77409e0b9c

aws autoscaling update-auto-scaling-group --auto-scaling-group-name Avenger-app-asg --default-cooldown 45