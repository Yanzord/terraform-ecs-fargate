data "template_file" "ecs-test" {
  template = file("${path.module}/hello-world.json")
  vars = {
    Name            = "ecs-test"
    environment     = var.env
    project         = var.project
    team            = var.team
  }
}