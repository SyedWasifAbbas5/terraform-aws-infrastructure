# Terraform AWS Infrastructure

Production-style AWS infrastructure built with **Terraform**, using reusable modules, infrastructure validation, GitHub Actions CI and Trivy security scanning.

> **Note:** AWS resources were not deployed in this portfolio environment. The Terraform configuration was validated locally and through GitHub Actions. AWS deployment requires user-provided credentials and may incur AWS charges.

## Architecture

```text
                         AWS
                          │
                   ┌──────▼──────┐
                   │     VPC     │
                   │ 10.0.0.0/16 │
                   └──────┬──────┘
                          │
              ┌───────────┴───────────┐
              │                       │
       Public Subnet           Private Subnet
        10.0.1.0/24             10.0.2.0/24
              │                       │
          EC2 Server              Internal
           t3.micro              Resources
              │
       Security Group
              │
           HTTP :80
```

## Project Overview

This project demonstrates how to provision and manage AWS infrastructure using **Infrastructure as Code (IaC)** with Terraform.

The infrastructure is organized into reusable modules for networking and compute, with security controls and automated CI validation.

## Technologies

* Terraform
* AWS
* Amazon VPC
* Amazon EC2
* Amazon Linux
* AWS Security Groups
* GitHub Actions
* Trivy
* HCL

## Infrastructure

### Networking

The Terraform configuration creates:

* VPC with `10.0.0.0/16` CIDR
* Public subnet
* Private subnet
* Internet Gateway
* Public route table
* Private route table
* Route table associations
* DNS support and hostnames

### Compute

The compute module provisions:

* Amazon Linux EC2 instance
* `t3.micro` instance type
* Application security group
* Encrypted root EBS volume
* IMDSv2 enforcement

## Security

Security was treated as part of the infrastructure design rather than an afterthought.

Implemented controls include:

* IMDSv2 required for EC2 metadata access
* Encrypted EC2 root volume
* No SSH access exposed through the security group
* Public IP assignment disabled at the subnet level
* Infrastructure security scanning with Trivy
* Terraform validation through GitHub Actions

## Project Structure

```text
terraform-aws-infrastructure/
│
├── .github/
│   └── workflows/
│       └── terraform-ci.yml
│
├── terraform/
│   ├── main.tf
│   ├── providers.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars.example
│   │
│   └── modules/
│       ├── network/
│       │   ├── main.tf
│       │   ├── variables.tf
│       │   └── outputs.tf
│       │
│       └── compute/
│           ├── main.tf
│           ├── variables.tf
│           └── outputs.tf
│
├── .gitignore
└── README.md
```

## Terraform Modules

### Network Module

Responsible for AWS networking resources:

* VPC
* Subnets
* Internet Gateway
* Route tables
* Route associations

### Compute Module

Responsible for:

* EC2 instance
* Security group
* Instance metadata configuration
* EBS encryption

This modular structure makes the infrastructure easier to maintain and extend.

## CI/CD Validation

Every push and pull request to `main` triggers GitHub Actions.

```text
Git Push / Pull Request
          │
          ▼
   Terraform Format
          │
          ▼
    Terraform Init
          │
          ▼
   Terraform Validate
          │
          ▼
    Trivy Security Scan
          │
          ▼
       PASS / FAIL
```

The pipeline validates the Terraform configuration and scans the infrastructure code for high and critical security misconfigurations.

## Local Validation

Terraform formatting:

```bash
terraform fmt -recursive
```

Initialize without configuring an AWS backend:

```bash
terraform -chdir=terraform init -backend=false
```

Validate the configuration:

```bash
terraform -chdir=terraform validate
```

Run the security scan through GitHub Actions after pushing changes.

## AWS Deployment

To deploy this infrastructure to AWS, configure AWS credentials and provide the required variables.

Example:

```bash
cd terraform

terraform init

terraform plan

terraform apply
```

To remove the infrastructure:

```bash
terraform destroy
```

> Do not run `terraform apply` or `terraform destroy` unless you have confirmed the AWS account, region, resources, and expected costs.

## Variables

Example configuration:

```hcl
aws_region   = "us-east-1"
project_name = "terraform-aws-infrastructure"
environment  = "production"
vpc_cidr     = "10.0.0.0/16"
```

Sensitive or environment-specific values should not be committed to Git.

## Outputs

The configuration exposes useful infrastructure outputs including:

* VPC ID
* Public subnet ID
* Private subnet ID
* Security group ID
* EC2 instance ID

## Key DevOps Practices Demonstrated

* Infrastructure as Code
* Modular Terraform design
* AWS networking
* Cloud compute provisioning
* Infrastructure security
* Security-as-code scanning
* Automated Terraform validation
* GitHub Actions CI
* Environment-based configuration
* Reproducible infrastructure

## Important Note

This repository is designed as a **production-style portfolio project**.

The Terraform code is structured for real AWS deployment, but AWS resources were intentionally not created during development to avoid unnecessary cloud costs.

All Terraform configuration and security validation was performed locally and through GitHub Actions.

## License

MIT License
