resource "aws_lb" "ecs-test-lb" {
  name               = "ecs-test-alb-${var.env}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg-lb-ecs-test.id]
  subnets            = data.aws_subnet_ids.public_subnets.ids
 
  enable_deletion_protection = false

  tags = {
    Name        = "ecs-test-alb-${var.env}"
    environment = var.env
    project     = var.project
    team        = var.team
  }
}
 
resource "aws_alb_target_group" "tg-ecs-test" {
  name        = "ecs-test-tg-${var.env}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = element(tolist(data.aws_vpcs.main_vpc.ids), 0)
  target_type = "ip"
 
  health_check {
   healthy_threshold   = "3"
   interval            = "30"
   protocol            = "HTTP"
   matcher             = "200"
   timeout             = "3"
   path                = var.healthcheck_url
   unhealthy_threshold = "2"
  }

 depends_on = [aws_lb.ecs-test-lb]

  tags = {
    Name        = "ecs-test-tg-${var.env}"
    environment = var.env
    project     = var.project
    team        = var.team
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_lb.ecs-test-lb.id
  port              = 80
  protocol          = "HTTP"
 
  default_action {
   type = "redirect"
 
   redirect {
     port        = 443
     protocol    = "HTTPS"
     status_code = "HTTP_301"
   }
  }
}
 
resource "aws_alb_listener" "https" {
  load_balancer_arn = aws_lb.ecs-test-lb.id
  port              = 443
  protocol          = "HTTPS"
 
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.crt.arn
 
  default_action {
    target_group_arn = aws_alb_target_group.tg-ecs-test.id
    type             = "forward"
  }
}