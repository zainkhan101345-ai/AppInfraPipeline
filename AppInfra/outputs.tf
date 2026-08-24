# output "Jenkins_Machine_Id" {
#     value= module.ec2_instance.Jenkins_Machine_Id
# } 

# output "LoadBalancerArn" {
#     value= module.LoadBalancer.aws_lb_arn
# } 


output "NodeEc2IP" {
    value= module.NodeEC2.NodeEc2_id
} 