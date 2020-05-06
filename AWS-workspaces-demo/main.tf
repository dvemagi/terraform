provider "aws" {
  region = "eu-west-1"
}

variable "password" {
  type        = string
  description = "Password di windows"
}

variable "env" {
  type        = string
  description = "Nome dell'ambiente"
}

module "network" {
  source = "./modules/network/"
  env    = var.env
}

module "ds" {
  source = "./modules/directory/"

  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.private_subnets
  password   = var.password
  env        = var.env
}

module "wks" {
  source = "./modules/workspaces/"

  vpc_id     = module.network.vpc_id
  subnet_ids = module.network.private_subnets
  env        = var.env
  ds_id      = module.ds.ds_id
}