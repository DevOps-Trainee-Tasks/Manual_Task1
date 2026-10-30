terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}
provider "aws" {
  region = local.aws_region
}

module "vpc" {
  source = "./modules/vpc"
  nat_gateway_public_subnet_index = 0

cidr = "10.0.0.0/24"

  available_zones_list = [
    "us-east-1a",
    "us-east-1b"
  ]
  public_subnets = [
    "10.0.0.0/27",
    "10.0.0.32/27"
  ]
  private_servers_subnets = [
    "10.0.0.64/27",
    "10.0.0.96/27"
  ]
  private_db_subnets = [
    "10.0.0.128/27",
    "10.0.0.160/27"
  ]
}

module "sg" {
  source = "./modules/sg"
  main_vpc_id = module.vpc.vpc_id


  security_groups = {

    bastion_sg = {
        ingress_port_tcp = 22
        allowed_cidr_block = var.my_ip
        allow_all_egress = true

    }

    alb_sg = {
        ingress_port_tcp = 80
        allowed_cidr_block = "0.0.0.0/0"
        allow_all_egress = true

    }

    bastion-servers_sg = {
        ingress_port_tcp = 22
        allowed_security_groups = ["bastion_sg"]
    }

    alb-llm_sg = {
        ingress_port_tcp        = 11434
        allowed_security_groups = ["alb_sg"]
        allow_all_egress = true

    }

    rds_sg = {
        ingress_port_tcp        = 5432
        allowed_security_groups = ["alb-llm_sg", "bastion_sg"]
    }

  }
}
