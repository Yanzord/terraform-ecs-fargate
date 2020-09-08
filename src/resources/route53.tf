data "aws_route53_zone" "devops-zone" {
  name         = "${var.record}."
  private_zone = false
}

resource "aws_route53_record" "devops" {
  zone_id = data.aws_route53_zone.devops-zone.zone_id
  name    = "ecs-test.${data.aws_route53_zone.devops-zone.name}"
  type    = "A"

  alias {
    name                   = aws_lb.ecs-test-lb.dns_name
    zone_id                = aws_lb.ecs-test-lb.zone_id
    evaluate_target_health = true
  }
}