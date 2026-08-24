In this project, I demonstrated hands-on experience with Terraform, AWS, networking, and shell scripting by building a Jenkins CI/CD pipeline that provisions infrastructure using Terraform.

The infrastructure, deployed in AWS eu-west-1 (Ireland), includes a VPC with public and private subnets. The public subnet hosts a Node.js application on port 3000, while the private subnet hosts an RDS MySQL database on port 3306 with no direct internet access.

I configured an Application Load Balancer with a Target Group to route traffic to EC2 instances and Route 53 for DNS-based access to the application.


