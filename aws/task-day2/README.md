```Activity 3```

You need to create a bucket and try to versioning the objects inside the bucket and analyse the result. Once you made the bucket it'll only be accessible from your IAM user and after uploading the object just remove the write access, then try to dowload and upload the object and analyse the result.

Avoid giving * permission in policy.

Things you will learn:
 - S3
 - S3 policy
 - Versioning


```Activity 4```

Create a S3 bucket and host a static website of Nginx through S3 feature after that integrate cloudFront service with your S3 bucket to overcome the latency and then access your static website through cloudFront url. Now change the content and hit again remember cache will not be taken at that time

Things you will learn:
 - S3
 - S3 policy
 - Object policy
 - cloudFront 
 - Nginx
 - invalidation option


```Activity 5```

Create a Instance inside VPC network if already exist if not then make whole infrastructure with the help of aws-cli tool

Perform operations below through aws-cli:
 - Start instance 
 - Stop instance
 - Restart instance
 - Terminate instance
 - Attach IAM role to that instance
 - Make ALB internet facing 

Good to do , If above implemented then implement this by aws-acli with single click, first do manually on console