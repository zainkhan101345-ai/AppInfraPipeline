# AWS Infrastructure Automation with Terraform & Jenkins

A hands-on AWS project demonstrating practical experience with **Terraform, AWS networking, CI/CD, and shell scripting**.

## Architecture

![AWS Infrastructure Architecture](architecture-diagram.png)

The infrastructure is deployed in **AWS eu-west-1 (Ireland)** using a VPC with CIDR `11.0.0.0/16`. The VPC contains a public subnet `11.0.1.0/24` hosting a Node.js application on port `3000`, and a private subnet `11.0.3.0/24` hosting an RDS MySQL database on port `3306`.

The private subnet has no direct internet access, keeping the database isolated from public traffic. An Internet Gateway provides internet connectivity to the public subnet.

## Request Flow

```text
User
  ↓
Route 53 (zaink.store)
  ↓
Application Load Balancer
  ↓
Target Group
  ↓
EC2 (Node.js :3000)
  ↓
RDS MySQL (:3306)
```

## CI/CD Flow

```text
GitHub
  ↓
Jenkins
  ↓
Terraform
  ↓
AWS Infrastructure
```

Jenkins automates the Terraform workflow to provision and manage the AWS infrastructure.

## Terraform Structure

The infrastructure is organized into reusable Terraform modules for networking, security groups, RDS, EC2, target groups, load balancing, Route 53, and ACM.

```text
Networking
SecurityGroup
Rds
ec2
TargetGroup
LoadBalancer
HostedZone
CertManager
Route53_record
```

## Technologies

**Terraform · AWS · Jenkins · Node.js · MySQL · Bash/Shell Scripting**

## Project Objective

This project demonstrates practical experience in **AWS infrastructure design, Infrastructure as Code, networking, security, CI/CD automation, DNS, load balancing, and cloud deployment**.

<img width="1110" height="714" alt="image" src="https://github.com/user-attachments/assets/145fb53b-1b5a-4f52-b8b8-586beb0f1eb2" />
