provider "aws" {
  region = var.region
}

terraform {
    backend "s3" {
    }
}

variable "env" {
  default = "dev"
}

variable "project" {
  default = "devops"
}

variable "team" {
  default = "arquitetura"
}

variable "region" {
  default = "us-east-1"
}

variable "vpc_name" {
  default = "vpc-dev"
}

variable "private_subnets" {
    type = map
    default = {
        "subnet1"    = "dev-vpc-private-a"
        "subnet2"    = "dev-vpc-private-b"
        "subnet3"    = "dev-vpc-private-c"
    }
}

variable "public_subnets" {
    type = map
    default = {
        "subnet1"    = "dev-vpc-public-a"
        "subnet2"    = "dev-vpc-public-b"
        "subnet3"    = "dev-vpc-public-c"
    }
}

variable "allowed_cidrs" {
  default = ["0.0.0.0/0"]
}

variable "healthcheck_url" {
  default = "/"
}

variable "domain" {
  default = ""
}

variable "record" {
  default = ""
}