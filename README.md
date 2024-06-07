# crossbridge-iac-example
This repository contains an assignement around this repository: [https://github.com/mkosir/typeorm-express-typescript](https://github.com/mkosir/typeorm-express-typescript).

## Objectives
1. Infrastructure Setup: Use either Terraform or AWS CloudFormation to create and manage the necessary AWS cloud infrastructure. This should include, but not be limited to:
- EC2 instances or ECS/EKS for container orchestration.
- RDS or Aurora for the PostgreSQL database.
- VPC, Subnets, and Internet Gateway for network configuration.
- Load Balancers (ALB) for distributing incoming application tra\ic.
- Auto Scaling to handle changes in load.
2. Dockerization: Containerize the given Node.js application using Docker. Ensure that the Docker setup is optimized for a production environment.
- Provide a Dockerfile to build the application container.
3. CI/CD Pipeline: Set up a CI/CD pipeline using AWS CodePipeline, GitHub Actions, or any other CI/CD tool to automate the testing and deployment of the application.
- The pipeline should build the Docker container.
- Run tests to ensure the build is stable.
- Deploy the container to AWS ECS or EKS.
4. Monitoring and Alarms: Utilize AWS CloudWatch to set up monitoring and alarms.
- Track key metrics like CPU usage, memory usage, disk I/O, and network trafic.
- Set up alarms to notify you of potential issues (e.g., high CPU usage, low disk space, or downtime).
5. Documentation: Provide detailed documentation on the architecture and setup.
- Include an architectural diagram showing the components of your infrastructure.
- Step-by-step instructions on how to deploy the application.
- Guide on how to monitor the application and respond to alarms.

## Deliverables
1. IaC Scripts: Include all Terraform or AWS CloudFormation scripts used to define and provision the cloud infrastructure.
2. Docker Configuration: The Dockerfile and any docker-compose.yml files used.
3. CI/CD Configuration: Configuration files and scripts for the CI/CD pipeline.
4. Operational Documentation: A README.md file that includes:
- Architectural overview with a diagrams
- Setup instructions.
- Monitoring and alarm management guide.
5. Test Suites: Ensure the application has relevant tests and they are documented on how to run them.

## Solution

### Components
1. [Github private repository](https://github.com/damontic/crossbridge-iac-example).
The repository contains the following key directories:
- iac: where the AWS resources are created.
- iac/check_scripts: bash scripts used to confirm the correct state of the resources created in AWS.
- cicd: where the CICD pipelines are defined.
- docs: where all documentation is found.

### Deliverables
- some documentation
- infrastructure as code in Terraform
- a single bash script to build the docker image and publish to ECR

### Missing Deliverables
- architecture diagram
- monitoring
- security
- testing in CI
- CD pipeline
- more documentation

### AWS account unavailability
Given that I do not have access to an AWS account and none was provided, I decided to tackle the problem using [localstack](https://www.localstack.cloud/) which is [compatible with multiple AWS services](https://docs.localstack.cloud/user-guide/aws/feature-coverage/).
This means that there mostly will be some steps that won't work while following the [how to deploy](docs/how_to_deploy.md) in AWS. But most of the steps will be very similar.

### AWS Terraform provider issues with latest versions while creating ELBs
This [bug](https://github.com/hashicorp/terraform-provider-aws/issues/37138) made me work with version 5.45.0 of the AWS provider.

