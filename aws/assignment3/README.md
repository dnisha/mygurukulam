Continue to the previous assignment 1 and use your both nginx AMI's for displaying webpage and use your images from S3 bucket.

## Setup nginx & there should be 1 ec2 in each private subnet .
    - 1 bastion host in public subnet .
    - port 22 of bastion host should only accessible from your public ip.
    - nginx welcome page with path '/ninja1' on first ec2 should display `Image-1`.
    - nginx welcome page with path '/ninja2' on second ec2 should display `Image-2`.
    - port 22 of  both the nginx servers should only be accessible from  bastion host.

## Create target group for each nginx server.
## Create Application load balancer.
    - port 80 open of nginx server should only be accessible from your ALB.
    - port 80 open of ALB should only be accessible from your public IP.
    - ALB should only be accessible though your public IP none else.
    - create listener rule so that {YOUR-ALB-DNS-NAME}/ninja1 should display welcome page of first ec2.
    - create listener rule so that {YOUR-ALB-DNS-NAME}/ninja2 should display welcome page of second ec2.

## Push all the updated images of the webpage to S3 bucket defined folders through any EC2 instance and maintain repo on that server only.

## You need to create a IAM user and a S3 Bucket on any of the region, Kindly follow as mentioned below :
 - Create 2 folders prod and nonprod inside that bucket.
 - Upload any different image files inside both folders.
 - Create a role for the above specific task and it should only be access S3 full access
 - A bucket should only be accessible from your both root, IAM user and nginx application.
 - Restrict the access of IAM user to access prod folder but able to access the nonprod folder.
 - Set IAM and bucket policies in such a way that it accomplished the above points.

## suppose organization wants to get the page access quick, so you need to implement CDN and fetch the images through CDN instead S3, use same role in the CDN which you are using in EC2 without any modification of policy.

## Make your own IAM user and assign minimal permissions to yourself for this task.

## Make a automation script of above task and display the webpages according to the questions.

NOTE: 
1. Don't use any secret and access key.
2. First do this manually and then apply automation to it.
3. Do not use your local system.
4. Do not use aws root account
5. Kindly avoid All traffic to sg group

Things you will learn:
 - IAM policies
 - Bucket policy
 - ALB
 - ALB rules
 - S3
 - Path based routing 
 - IAM Trust Relationship