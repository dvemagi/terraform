provider "aws" {
  region = "eu-south-1"
}

module "network" {
    source = "./modules/network/"
}

module "directory" {
    source = "./modules/directory/"
}