variable "env" {
  type = string
  description = "Nome dell'ambiente"
}

variable "region" {
  type = string
}

variable "CIDR" {
  type = string
}

# Partendo dal CIDR della VPC aggiungo 2 bit alla mask e assegno alle network 
module "subs" {
  source = "hashicorp/subnets/cidr"

  base_cidr_block = var.CIDR
  networks = [
    {
      name     = "pub-a"
      new_bits = 4
    },
    {
      name     = "pub-b"
      new_bits = 4
    }

  ]
}



module  "vpc" {

  source = "terraform-aws-modules/vpc/aws"

  cidr = var.CIDR

  azs             = ["${var.region}a", "${var.region}b"]
  public_subnets  = [module.subs.networks[0].cidr_block , module.subs.networks[1].cidr_block]

  enable_ipv6 = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  
  public_subnet_tags = {
    Name = "${var.env}-pub"
  }

  public_route_table_tags = {
    Name = "${var.env}-pub-route"
  }

  igw_tags = {
    Name = "${var.env}-igw"
  }
  
  tags = {
    app       = "${var.env}"
    Name      = "${var.env}-vpc"
  }

}