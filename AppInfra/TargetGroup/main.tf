variable vpc_id {}
variable tg_name {}
variable tg_port {}
variable tg_protocol {}
variable ec2_id {}




output aws_lb_target_group_arn {
  value       = aws_lb_target_group.tg.arn
}

resource "aws_lb_target_group" "tg" {
  name           = var.tg_name
  protocol = var.tg_protocol
  port = var.tg_port
  vpc_id= var.vpc_id
  health_check {
    path= "/"
    port =3000 #we will check Node server
    healthy_threshold =6 # 6 continous 200 resp means app(ec2) is healthy
    unhealthy_threshold =2 # 2 continous resp with code not equal to 200 means app(ec2) is unhealthy
    interval=30 # it sends req after very 20 sec
    matcher ="200" #health check will fail if response is not 200

  }

  
}

resource "aws_lb_target_group_attachment" "tg_attachment" {
  target_group_arn      = aws_lb_target_group.tg.arn
  target_id = var.ec2_id
  port = 3000
}


