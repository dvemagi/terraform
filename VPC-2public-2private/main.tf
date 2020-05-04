provider "aws" {
  region = "eu-south-1"
}

module "network" {
    source = "./modules/network/"
}

module "directory" {
    source = "./modules/directory/"
    
    vpc_id = module.network.vpc_id
    subnet_ids = module.network.public_subnets
}