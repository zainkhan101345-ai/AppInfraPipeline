variable lb_name {}
variable is_internal {}
variable lb_type {}
variable security_groups {}
variable subnet_ids {}
variable lb_listener_port {}
variable lb_listener_protocol {}
variable lb_listener_port_HTTPS {}
variable lb_listener_protocol_HTTPS {}
variable acm_arn {}
variable lb_listener_default_action_type {}
variable target_group_arn {}






output aws_lb_arn {
  value       = aws_lb.LoadBalancer.arn
}

output aws_lb_dns_name {
  value       = aws_lb.LoadBalancer.dns_name
}
output aws_lb_zone_id {
  value       = aws_lb.LoadBalancer.zone_id
}
resource "aws_lb" "LoadBalancer" {
  name           = var.lb_name
  internal = var.is_internal
  load_balancer_type = var.lb_type
  security_groups= var.security_groups
  subnets= var.subnet_ids

  tags ={
    Name ="Load balancer"
  }

  
}


resource "aws_lb_listener" "LoadBalancerListener" {
  load_balancer_arn = aws_lb.LoadBalancer.arn
  port = var.lb_listener_port
  protocol = var.lb_listener_protocol
  

  default_action {
    type =var.lb_listener_default_action_type
    target_group_arn = var.target_group_arn
  }

  
}


resource "aws_lb_listener" "LoadBalancerListenerHTTPS" {
  load_balancer_arn = aws_lb.LoadBalancer.arn
  port = var.lb_listener_port_HTTPS
  protocol = var.lb_listener_protocol_HTTPS
  ssl_policy        = "ELBSecurityPolicy-FS-1-2-Res-2019-08"
  certificate_arn   = var.acm_arn

  default_action {
    type =var.lb_listener_default_action_type
    target_group_arn = var.target_group_arn
  }

  
}