resource "aws_security_group" "sg-ecs-task" {
    name = "sg_ecs-test-task"
    vpc_id = element(tolist(data.aws_vpcs.main_vpc.ids), 0) 

    ingress {
        description = "Internal access to API"
        from_port   = 5000
        to_port     = 5000
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "sg_ecs-test-task"
        env = var.env
        project = var.project
        team = var.team
    }
}

resource "aws_security_group" "sg-lb-ecs-test" {
    name = "sg_lb-ecs-test"
    vpc_id = element(tolist(data.aws_vpcs.main_vpc.ids), 0) 

    ingress {
        description = "HTTP Access to external IPs"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = var.allowed_cidrs
    }

    ingress {
        description = "HTTPS Access to external IPs"
        from_port   = 443
        to_port     = 443
        protocol    = "tcp"
        cidr_blocks = var.allowed_cidrs
    }

    egress {
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "sg_lb-ecs-test"
        env = var.env
        project = var.project
        team = var.team
    }
}