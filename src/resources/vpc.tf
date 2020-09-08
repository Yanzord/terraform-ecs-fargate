data "aws_vpcs" "main_vpc" {
  tags = {
    Name = var.vpc_name
    environment  = var.env
    project = "devops"
  }
}

data "aws_subnet_ids" "private_subnets" {
  vpc_id = element(tolist(data.aws_vpcs.main_vpc.ids), 0)

  filter {
    name   = "tag:Name"
    values = [
      var.private_subnets["subnet1"],
      var.private_subnets["subnet2"],
      var.private_subnets["subnet3"]
    ]
  }

}

data "aws_subnet" "private_subnet_a_cidr_block" {
  id = element(tolist(data.aws_subnet_ids.private_subnets.ids), 0)
}

data "aws_subnet" "private_subnet_b_cidr_block" {
  id = element(tolist(data.aws_subnet_ids.private_subnets.ids), 1)
}

data "aws_subnet" "private_subnet_c_cidr_block" {
  id = element(tolist(data.aws_subnet_ids.private_subnets.ids), 2)
}

data "aws_subnet_ids" "public_subnets" {
  vpc_id = element(tolist(data.aws_vpcs.main_vpc.ids), 0)

  filter {
    name   = "tag:Name"
    values = [
      var.public_subnets["subnet1"],
      var.public_subnets["subnet2"],
      var.public_subnets["subnet3"]
    ]
  }
}

data "aws_subnet" "public_subnet_a_cidr_block" {
  id = element(tolist(data.aws_subnet_ids.public_subnets.ids), 0)
}

data "aws_subnet" "public_subnet_b_cidr_block" {
  id = element(tolist(data.aws_subnet_ids.public_subnets.ids), 1)
}

data "aws_subnet" "public_subnet_c_cidr_block" {
  id = element(tolist(data.aws_subnet_ids.public_subnets.ids), 2)
}