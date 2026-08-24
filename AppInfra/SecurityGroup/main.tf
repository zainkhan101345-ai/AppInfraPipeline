variable vpc_id {}
variable ec2_sg_name {}
variable ec2_Node_sg_name {}
variable Sql_sg_name {}
variable public_subnets_cidr {}


output ec2_sg_id {
  value       = aws_security_group.ec2_sg_http_ssh.id
}

output NodeJS_ec2_sg_id {
  value       = aws_security_group.ec2_NodeJS_sg.id
}


output SQL_sg_id {
  value       = aws_security_group.SQL_sg.id
}


resource "aws_security_group" "ec2_sg_http_ssh" {
  name        = "${var.ec2_sg_name}-sg"
  description = "Allow inbound traffic on ports 22(ssh) and port 80(http)"
  vpc_id=var.vpc_id

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


resource "aws_security_group" "ec2_NodeJS_sg" {
    name="${var.ec2_Node_sg_name}-sg"
    description= "Enable Node JS on port 8080"
    vpc_id= var.vpc_id

    ingress {
        description ="Allow traffic from anywhere to port 3000(Node JS)"
        from_port=3000
        to_port=3000
        protocol="tcp"
        cidr_blocks = ["0.0.0.0/0"]

        
    }
    tags={
        Name = "Security Groups to allow Node JS"
    }
}


resource "aws_security_group" "SQL_sg" {
    name="${var.Sql_sg_name}-sg"
    description= "Enable SQL on port 3306"
    vpc_id= var.vpc_id

    ingress {
        description ="Allow traffic from anywhere to port 3306(SQL)"
        from_port=3306
        to_port=3306
        protocol="tcp"
        cidr_blocks = var.public_subnets_cidr

        
    }
    tags={
        Name = "Security Groups to allow 3306(SQL)"
    }
}