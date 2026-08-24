variable GroupName {}
variable SubnetIds {}
variable SGIds {}
variable identifier {}
variable db_Name {}
variable db_UserName {}
variable db_Pass {}


output "rds_endpoint" {
  value = aws_db_instance.mysql.endpoint
}

output "rds_address" {
  value = aws_db_instance.mysql.address
}

resource "aws_db_subnet_group" "MainGroup" {
       name= var.GroupName

       subnet_ids = var.SubnetIds   
}

resource "aws_db_instance" "mysql"{
    identifier = var.identifier
    engine= "mysql"
    engine_version ="8.0"
    instance_class ="db.t3.micro"
    allocated_storage=20 ##RDS gets 20 GB disk space.

    db_name= var.db_Name
    username= var.db_UserName
    password= var.db_Pass

    db_subnet_group_name =var.GroupName
    vpc_security_group_ids = var.SGIds

    skip_final_snapshot = true



}