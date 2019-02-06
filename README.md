# Sonar AMI Module

This repo contains a Module for how to deploy Sonarqube on AWS using [Terraform](https://www.terraform.io/). Sonarqube is a source scanning tool that ensures better code quality.

This Module includes:
- **rds-security-group-rules**: This module defines the security group rules for the backend database used by sonarqube.
- **sonar-database**: This module defines the postgres backend database setup for sonarqube.
- **sonar-security-group-rules**: This module defines the security group rules used by the Sonarqube EC2 instance

## What's a Module?
Modules in Terraform are self-contained packages of Terraform configurations that are managed as a group. Modules are used to create reusable components in Terraform as well as for basic code organization. A **root module** is the current working directory when you run `terraform apply` or get, holding the Terraform configuration files. It is itself a valid module. The root module in this project is **sonar-server**. See [https://www.terraform.io/docs/modules/usage.html] for more details for creating your own module.

## Prerequisites
- [Terraform](https://www.terraform.io/intro/getting-started/install.html)
- [Packer](https://www.packer.io/docs/install/index.html)
- An active [AWS account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/)

## How do you use this Module?
This Module has the following folder structure:
- [modules](https://github.com/department-of-veterans-affairs/ascent-sonar-ami/tree/master/modules): This folder contains the reusable code for this Module, broken down into one or more modules.
- [packer](https://github.com/department-of-veterans-affairs/ascent-sonar-ami/tree/master/packer): This folder contains all of the scripts necessary to create an [AWS AMI](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html) of a Sonarqube server.

##### To Deploy Sonarqube
1. Create an AMI that has sonarqube installed (using the [packer scripts](https://github.com/department-of-veterans-affairs/ascent-sonar-ami/tree/master/packer))
2. Deploy that AMI in a private subnet with a MySQL AWS RDS instance using the Terraform [sonar-server](https://github.com/department-of-veterans-affairs/ascent-sonar-ami/tree/master/modules/sonar-server) module.
