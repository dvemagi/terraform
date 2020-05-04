provider "aws" {
  region = "eu-south-1"
}

module "network" {
    source = "./modules/network/"
}

module "ds" {
    source = "./modules/directory/"

    vpc_id = "${modules.network.vpc_id}"
    subnet_ids = "${modules.network.private_subnets}"
}