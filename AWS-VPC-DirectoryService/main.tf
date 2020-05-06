provider "aws" {
  region = "eu-west-1"
}

module "network" {
    source = "./modules/network/"
}

module "ds" {
    source = "./modules/directory/"

    vpc_id = module.network.vpc_id
    subnet_ids = "${module.network.private_subnets}"
}