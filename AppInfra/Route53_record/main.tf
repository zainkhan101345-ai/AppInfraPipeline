variable zone_id {}
variable domain_name {}
variable lb_dns_name {}
variable lb_zone_id {}

resource "aws_route53_record" "appRecord" {
    zone_id=var.zone_id
    name=var.domain_name
    type="A"
    alias{
        name=var.lb_dns_name
        zone_id=var.lb_zone_id
        evaluate_target_health=true
    }


}