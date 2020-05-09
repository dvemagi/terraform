
variable "env" {
  type = string
  description = "Nome dell'ambiente"
}

variable "region" {
  type = string
  description = "region AWS in cui effettuare il deploy (es. eu-south-1)"
}

variable "CIDR" {
  type = string
  description = "Network del VPC (es. 172.31.0.0/21)"
}

provider "aws" {
  region = var.region
}

module "network" {
  source = "./modules/network/"
  env    = var.env
  region = var.region
  CIDR = var.CIDR
}
