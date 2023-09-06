## Assignment-1
```
In this assignment you have to learn about deployment strategies:
    - Recreate deployment 
    - Rolling deployment 
    - Blue-green deployment 
    - A/B  deployment
    - Canary deployment 

After this you need to implement these 2 below deployment strategies:
Must Do
    - Recreate deployment 
    - Rolling deployment 
Good to  Do
    - Blue Green deployment 
    - Canary deployment 

Recommendation
    - Don't straight forward jump into creating the utility, first do it manually

github-link --> https://github.com/OT-TRAINING/DeploymentStrategies

Hint :
1. Use ASG
2. Use LB
3. Use EC2 service
4. Use AMI Snapshot

```
### Recreate Deployment Strategy:
```
The "Recreate Deployment" strategy involves taking down the current instances and creating new ones with the updated code or configuration. This approach typically results in a brief downtime during the switch-over.

Here's how to perform a Recreate Deployment using EC2, ALB, and Target Groups:
```
### Step 1: Prepare Your New EC2 Instances
```
Launch new EC2 instances with the updated code and configurations.

Ensure that these instances are in the same subnet and security group as the existing instances.

Test your application on these new instances to ensure it works correctly.
```

### Step 2: Configure a Target Group
```
Create a new target group in the AWS EC2 Console.

Register the new EC2 instances with the target group.

```

### Step 3: Update the ALB Listener
```
Go to your Application Load Balancer (ALB) settings in the AWS Console.

Edit the listener rules to route traffic to the new target group (the one containing the updated instances).

```

### Step 4: Deregister Old Instances
```
Wait for the new instances to become healthy in the target group.

Deregister the old instances from the target group.

This process will cause a brief downtime during the switch-over when updating the ALB listener rules. However, the downtime should be minimal if everything is configured correctly.

```

### Rolling Deployment Strategy:
```
A "Rolling Deployment" strategy involves gradually updating instances behind an ALB without taking the entire application down. This minimizes downtime and ensures a smooth transition.

Here's how to perform a Rolling Deployment using EC2, ALB, and Target Groups:
```

### Step 1: Prepare Your New EC2 Instances
```
Launch new EC2 instances with the updated code and configurations.

Ensure that these instances are in the same subnet and security group as the existing instances.

Test your application on these new instances to ensure it works correctly.
```

### Step 2: Configure a Target Group
```
Create a new target group in the AWS EC2 Console.

Register the new EC2 instances with the target group.
```

### Step 3: Update the ALB Target Group
```
Go to your Application Load Balancer (ALB) settings in the AWS Console.

Edit the target group for the ALB listener to include the new target group.
```
### Step 4: Gradually Replace Instances
```
Wait for the new instances to become healthy in the new target group.

Gradually reduce the desired capacity of the old target group (this will gradually drain traffic from the old instances).

Monitor the health of instances during the deployment and adjust the capacity as needed.

This approach ensures that your application remains available during the update as only a subset of instances is replaced at any given time.
```





