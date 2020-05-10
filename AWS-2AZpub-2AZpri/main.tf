# Terraform per la creazione di un VPC con 2 Subnet Pubbliche e duee private in 2AZ
#
# Copyright (c) 2020 Dario Vemagi
# Under MIT License

#Variabili
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

# Deploy

provider "aws" {
  region = var.region
}

module "network" {
  source = "./modules/network/"
  env    = var.env
  region = var.region
  CIDR = var.CIDR
}
