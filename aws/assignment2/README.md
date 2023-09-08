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



