```Activity 1```

- Setup nginx & there should be 1 ec2 in each private subnet .
    - 1 bastion host in public subnet .
    - port 22 of bastion host should only accessible from your public ip.
    - nginx welcome page with path '/ninja1' on first ec2 should display  `Welcome ninja-1`.
    - nginx welcome page with path '/ninja2' on second ec2 should display  `Welcome ninja-2`.
    - port 22 of  both the nginx servers should only be accessible from  bastion host.
- Create target group for each nginx server.

- Create Application load balancer.
    - port 80 open of nginx server should only be accessible from your ALB.
    - port 80 open of ALB should only be accessible from your public IP.
    - ALB should only be accessible though your public IP none else.
    - create listener rule so that {YOUR-ALB-DNS-NAME}/ninja1 should display welcome page of first ec2.
    - create listener rule so that {YOUR-ALB-DNS-NAME}/ninja2 should display welcome page of second ec2.


    ```Activity 2```

this is your ASG task

Create an infrastructure with the following resources or use existing resources: 
  - VPC 
  - 2 public subnets 
  - 2 private subnets 
  - 1 instance on one of the private subnets 
  - create internet facing application load balancer 
  - create Autoscaling group and attach your above load balancer 
  - attach CPU intensive dynamic tracking policy to your asg 

So in the above mentioned infrastructure, generate a CPU stress load on the server and analyse the result.
Try to complete your ASG and LB task by today.