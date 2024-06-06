# How to deploy?

This document describes how to deploy the application in a local environment that simulates AWS. Running in AWS should follow very similar steps but might need some extra steps.

## Dependencies
This was tested using [localstack](https://www.localstack.cloud/) in a local environment.
There might be some minor adjustements for this to work in AWS but most of the scripts should need only small modifications to achieve this.

## Publish the Docker image to ECR
1. Make sure you have access to an AWS account from your computer using a named profile in `~/.aws/config`. In this example we setup an `AWS_PROFILE` called `localstack`.
2. Run the following script:
```bash
$ devops/cicd/build_docker_image.sh 
```
This script receives three parameters.
The AWS_PROFILE which was configured in step 1.
The VERSION you want to assign to the new docker image.
The REPOSITORY_NAME which was specified in the [devops/iac/ecr.tf](../devops/iac/ecr.tf) file under the name attribute of the aws_ecr_repository resource.

## Running locally
- Make sure you have Docker running given that it is a dependency of localstack.
- Run localstack locally:
```bash
$ localstack start
```
- Create the infrastructure using the Terraform project found in the [iac](../iac) repository.
```bash
$ cd devops/iac
$ tofu plan 
```
- 