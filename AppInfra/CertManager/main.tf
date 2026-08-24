variable domain_name {}
variable hosted_zone_id {}

output "ACM_arn" {
  value = aws_acm_certificate_validation.main.certificate_arn
}

resource "aws_acm_certificate" "main"{
   domain_name = var.domain_name
   validation_method ="DNS"

   tags ={
       Environment ="production"
   }

   lifecycle {
     create_before_destroy= true
   }
}


resource "aws_route53_record" "acm_validation" {
    for_each ={
        for dvo in aws_acm_certificate.main.domain_validation_options:
        dvo.domain_name => {
            name= dvo.resource_record_name
            record= dvo.resource_record_value
            type= dvo.resource_record_type
        }
    }
    zone_id = var.hosted_zone_id
    name =  each.value.name
    type =each.value.type
    ttl=60 #Cache this DNS record for 60 seconds

      records = [each.value.record]
      allow_overwrite = true

}


resource "aws_acm_certificate_validation" "main" {
  certificate_arn = aws_acm_certificate.main.arn

  validation_record_fqdns = [
    for record in aws_route53_record.acm_validation :
    record.fqdn
  ]
}