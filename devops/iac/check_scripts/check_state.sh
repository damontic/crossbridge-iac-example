#! /bin/bash -xe

export AWS_PROFILE=localstack

# List ECR images
aws --output table ecr describe-repositories
aws --output table ecr list-images --repository-name crossbridge

# List ECS cluster 
aws --output table ecs list-clusters
aws --output table ecs describe-clusters --cluster main

# Describe ECS services
aws --output table ecs list-services --cluster main
aws --output table ecs describe-services --services typeorm-express-typescript --cluster main

# Describe Load Balancer
aws --output table elbv2 describe-load-balancers
LOAD_BALANCER_ARN=`aws elbv2 describe-load-balancers --query 'LoadBalancers[0].LoadBalancerArn' --output text`
aws --output table elbv2 describe-load-balancer-attributes --load-balancer-arn  "$LOAD_BALANCER_ARN"

# Describe EC2 instances
aws --output table ec2 describe-instances
