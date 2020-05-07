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

# Partendo dal CIDR della VPC aggiungo 4bit alla mask e assegno alle network 
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
    },
    {
      name     = "pri-a"
      new_bits = 4
    },
    {
      name     = "pri-b"
      new_bits = 4
    },



  ]
}



module  "vpc" {

  source = "terraform-aws-modules/vpc/aws"

  cidr = var.CIDR

  azs             = ["${var.region}-1a", "e${var.region}-1b"]
  private_subnets = [module.subs.networks[2].cidr_block , module.subs.networks[3].cidr_block]
  public_subnets  = [module.subs.networks[0].cidr_block , module.subs.networks[1].cidr_block]

  enable_ipv6 = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  one_nat_gateway_per_az = true
  

  public_subnet_tags = {
    Name = "${var.env}-pub"
  }

  public_route_table_tags = {
    Name = "${var.env}-pub-route"
  }

  private_subnet_tags = {
    Name = "${var.env}-pri"
  }

 private_route_table_tags = {
    Name = "${var.env}-pri-route"
  }

  igw_tags = {
    Name = "${var.env}-igw"
  }

  nat_gateway_tags = {
    Name = "${var.env}-natgw"
  }

nat_eip_tags = {
    Name = "${var.env}-nat-eip"
  }
  
  tags = {
    app       = "${var.env}"
    Name      = "${var.env}-vpc"
  }

}