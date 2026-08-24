variable aws_ami {}
variable instance_type {}
variable InstanceName {}
variable subnet_id {}
variable ec2_sg_id {}
variable enable_public_ip_address {}
variable install {}
variable public_keyM {}


output NodeEc2_id {
  value       = aws_instance.NodeEc2.id
}

resource "aws_instance" "NodeEc2" {
  ami           = var.aws_ami
  instance_type = var.instance_type
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.ec2_sg_id
    associate_public_ip_address = var.enable_public_ip_address
  tags = {
    Name = var.InstanceName
  }

  user_data = var.install
  user_data_replace_on_change = true
  key_name = "NewKey"

  
}
 