variable aws_ami {}
variable instance_type {}
variable InstanceName {}
variable enable_public_ip_address {}
variable public_keyM {}


output NodeEc2_id {
  value       = aws_instance.NodeEc2.id
}

resource "aws_security_group" "ec2_sg_http_ssh" {
  name        = "Allow http-sg"
  description = "Allow inbound traffic on ports 22(ssh) and port 80(http)"

  ingress {
    description = "Allow port 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


   ingress {
    description = "Allow HTTP request from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS request from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow Node req request from anywhere"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow outgoing request"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Security Groups to allow SSH and HTTP"
  }

}
resource "aws_instance" "NodeEc2" {
  ami           = var.aws_ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.ec2_sg_http_ssh.id]
 
  tags = {
    Name = var.InstanceName
  }

  key_name = "NewKey"

  
}
 