provider "aws"{
    region=var.aws_region
}



module "vpcsubnets"{
    source="./Networking"
    vpc_cidr=var.vpc_cidr
    public_subnets=var.public_subnets
    private_subnets=var.private_subnets
    availability_zone=var.availability_zone
}

module "SecurityGroups"{
    source="./SecurityGroup"
    vpc_id=module.vpcsubnets.vpc_id
    ec2_sg_name="Allows ssh and http/https"
    ec2_Node_sg_name="Allows Node js to run on ec2"
    Sql_sg_name="Allows SQL  to run on ec2"
    public_subnets_cidr=tolist(module.vpcsubnets.public_subnets_cidr)
}   

module "Rds"{
    source="./Rds"
    GroupName="rds_group"
    SubnetIds=tolist(module.vpcsubnets.private_subnets)
    SGIds=[module.SecurityGroups.SQL_sg_id]
    identifier="zkdb"
    db_Name=local.db["DB_NAME"]
    db_UserName=local.db["DB_USER"]
    db_Pass=local.db["DB_PASS"]
    
} 


module "NodeEC2"{
    source="./ec2"
    aws_ami=data.aws_ami.ubuntu.id
    instance_type="t2.medium"
    InstanceName="Node Js Server"
    public_keyM=var.public_key
    subnet_id=tolist(module.vpcsubnets.public_subnets)[0]
    ec2_sg_id=[module.SecurityGroups.ec2_sg_id,module.SecurityGroups.NodeJS_ec2_sg_id]
    enable_public_ip_address=true
    install=templatefile("./NodeJsInstaller/NodeJs-Installer.sh",{
             rds_endpoint =module.Rds.rds_endpoint   
             rds_address =module.Rds.rds_address  
             DBUSER= local.db["DB_USER"]
             DBPASS= local.db["DB_PASS"]
             DBNAME= local.db["DB_NAME"]
    })
  
    
} 



module "TargetGroup"{
    source="./TargetGroup"
    vpc_id=module.vpcsubnets.vpc_id
    tg_name="TargetGroup"
    tg_port=3000
    tg_protocol="HTTP"
    ec2_id=module.NodeEC2.NodeEc2_id
    
}   


module "LoadBalancer"{
    source="./LoadBalancer"
    lb_name="Load-balancer-Main"
    is_internal=false
    lb_type="application"
    security_groups=[module.SecurityGroups.ec2_sg_id]
    subnet_ids=tolist(module.vpcsubnets.public_subnets)
    lb_listener_port =80
    lb_listener_protocol ="HTTP"
    lb_listener_port_HTTPS=443
    lb_listener_protocol_HTTPS="HTTPS"
    acm_arn=module.ACM.ACM_arn
    lb_listener_default_action_type="forward"
    target_group_arn=module.TargetGroup.aws_lb_target_group_arn

} 



module "HostedZone"{
    source="./HostedZone"  
} 
   
module "ACM"{
    source="./CertManager"
    domain_name="zaink.store"
    hosted_zone_id = module.HostedZone.hosted_zone_id  
} 

module "record" {
    source="./Route53_record"
  
    zone_id = module.HostedZone.hosted_zone_id
    domain_name="zaink.store"
    lb_dns_name=module.LoadBalancer.aws_lb_dns_name
    lb_zone_id=module.LoadBalancer.aws_lb_zone_id
   
} 




