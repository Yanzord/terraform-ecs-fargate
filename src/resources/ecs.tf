resource "aws_ecs_cluster" "ecs-test" {
  name = "ecs-test-cluster-${var.env}"
  capacity_providers = ["FARGATE","FARGATE_SPOT"]

  tags = {
    Name        = "ecs-test"
    environment = var.env
    project     = var.project
    team        = var.team
  }
}

resource "aws_ecs_service" "ecs-test" {
  name                               = "ecs-test-service-${var.env}"
  cluster                            = aws_ecs_cluster.ecs-test.id
  task_definition                    = aws_ecs_task_definition.ecs-test.arn
  desired_count                      = 2
  deployment_minimum_healthy_percent = 50
  deployment_maximum_percent         = 200
  launch_type                        = "FARGATE"
  scheduling_strategy                = "REPLICA"
 
  network_configuration {
    security_groups  = [aws_security_group.sg-ecs-task.id]
    subnets          = data.aws_subnet_ids.private_subnets.ids
    assign_public_ip = false
  }
 
  load_balancer {
    target_group_arn = aws_alb_target_group.tg-ecs-test.arn
    container_name   = "ecs-test"
    container_port   = 5000
  }
 
  lifecycle {
    ignore_changes = [task_definition, desired_count]
  }
}