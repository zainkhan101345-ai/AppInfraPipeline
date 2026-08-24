output "hosted_zone_id" {
    value = aws_route53_zone.hosted_zone.zone_id
}

resource "aws_route53_zone" "hosted_zone" {
    name = "zaink.store"
}


