resource "aws_ecs_task_definition" "ecs-test" {
  family                   = "ecs-test"
  container_definitions    = data.template_file.ecs-test.rendered

  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_task_execution_role.arn
  network_mode             = "awsvpc"
  cpu                      = 1024
  memory                   = 2048
  requires_compatibilities = ["FARGATE"]

   tags = {
    Name        = "ecs-test-task"
    environment = var.env
    project     = var.project
    team        = var.team
  }
}