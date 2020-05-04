provider "aws" {
  region = "eu-south-1"
}

module "vpc" {
    source = "./modules/network/"
}

module "ds" {
    source = "./modules/directory/"

    vpc_id = modules.vpc.vpc_id
    subnet_ids = modules.vpc.private_subnets
}