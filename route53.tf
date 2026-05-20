resource "aws_route53_zone" "domain" {
  name    = var.domain_name
  comment = "staging"

  vpc {
    vpc_id = var.vpc_id
  }
}



# Kafka DNS records

resource "aws_route53_record" "kafka_1" {
  zone_id = aws_route53_zone.domain.zone_id
  name    = "kafka1.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.kafka[0].private_ip]
}

resource "aws_route53_record" "kafka_2" {
  zone_id = aws_route53_zone.domain.zone_id
  name    = "kafka2.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.kafka[1].private_ip]
}

resource "aws_route53_record" "kafka_3" {
  zone_id = aws_route53_zone.domain.zone_id
  name    = "kafka3.${var.domain_name}"
  type    = "A"
  ttl     = 300
  records = [aws_instance.kafka[2].private_ip]
}