# create alb
aws elbv2 create-load-balancer --name vault-alb --subnets "subnet-0f1a64e0ec816a4a2" "subnet-0f363c8c8b707d238" --security-groups sg-03cd08fbe564ec3e8 --scheme internet-facing

# attch iam role to instance
aws ec2 associate-iam-instance-profile --instance-id i-083aa858c77c8395e --iam-instance-profile Name=dicover-ec2

# instance operation
aws ec2 start-instances --instance-ids i-083aa858c77c8395e
aws ec2 stop-instances --instance-ids i-083aa858c77c8395e
aws ec2 reboot-instances --instance-ids i-083aa858c77c8395e
aws ec2 terminate-instances --instance-ids i-083aa858c77c8395e
