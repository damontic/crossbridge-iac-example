# How to deploy?

This document describes how to deploy the application in a local environment that simulates AWS. Running in AWS should follow very similar steps but might need some extra steps.

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