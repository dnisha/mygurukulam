=============
Assingment-2
=============
                                                   
Perform this first: (Manually)
- Create instance
- install nginx on instance 
- create AMI - 1
- create instance from above AMI and make V1 - 2
- create instance from above AMI and make V2.- 3
- Make both V1 and V2 AMI's 
- Now you have 3 AMI's total 

## Now perform the tasks:

You have to continue yesterday's strategy with autoscaling group, now you have to attach asg on LB and follow the same strategy. 

1. Now assume that you have some conflict in V2, try to revert back to previous V1. ( do this manually first)
 
2. You need to pull content from VCS git and push your images on S3 bucket using aws-cli. (Do not use secrete and access keys)

3. You need to create a frontend including images which will be fetched directly from S3 bucket. 

4. Attach the policy to asg and increase the stress according to policy mentioned then analyse the result. ( Try every policy )
    - Avg CPU utilization
    - Network bytes in/out
    - ALB requests count per target.

5. Enter in the server and do some changes in server in order to make server unhealthy, now analyse the result how ASG can help you to maintain your instance desire state.

NOTE 1: You need to create the utility in such a way that it will make AMI of specific version and attach to the asg and perform the rolling deployment strategie. In case of revert back you should also have the function of revert back feature. 

NOTE 2: But always remember first do it all the tasks manually.

GOOD TO DO:
Do this automation with Blue Green Deployment and add CloudFront in front of Load Balancer to access the website in order to overcome latency.


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
--launch-template "LaunchTemplateName=MyLaunchTemplate,Version=1" \
--min-size 1 \
--max-size 5 \
--desired-capacity 2 \
--vpc-zone-identifier "subnet-04dffad7706297237","subnet-05b73760f13f91dca" \
--availability-zones "ap-south-1a" "ap-south-1b" \
--default-cooldown 300 \
--health-check-type EC2 \
--health-check-grace-period 120 \
--tags "Key=Name,Value=MyAutoScalingGroup,PropagateAtLaunch=true"

aws autoscaling attach-load-balancer-target-groups \
--auto-scaling-group-name Avenger-app-asg \
--target-group-arns arn:aws:elasticloadbalancing:ap-south-1:313578065517:targetgroup/custom-app-tg/7e1bdb77409e0b9c

aws autoscaling update-auto-scaling-group --auto-scaling-group-name Avenger-app-asg --default-cooldown 45

