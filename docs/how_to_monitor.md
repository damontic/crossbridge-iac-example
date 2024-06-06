# How to monitor and respond to alarms?

We divide metrics into three categories:
- infrastructure metrics
- application metrics
- domain matrics

## Infrastructure Metrics
Monitoring is being done using Cloudwatch and Cloudwatch logs.
The applications deployed in ECS are configured to send their logs to these systems from which we can define alerts that run Lambda function scripts that run some self healing logic.

If we were using EC2 instances we would have installed the Cloudwatch agent into the machines to retrieve metrics for each machine.

## Application Metrics
Application metrics describe how much resources an applicaiton is using.
For nodejs application we can use libraries such as [prom-client](https://www.npmjs.com/package/prom-client) to get some of this information.

## Domain metrics
There metrics are defined as functional requirements and implemented in the application. the application must have the logic to expose them to another system or to push them to some data storage.

# Triggers and Alerts
