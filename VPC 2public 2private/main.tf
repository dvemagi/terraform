provider "aws" {
  region = "eu-west-1"
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

module "vpc" {
  source = "../../"

  name = "tf-test-vpc"

  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_ipv6 = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway = true
  one_nat_gateway_per_az = true
  

  public_subnet_tags = {
    Name = "tf-test-pub"
  }
  
  private_subnet_tags = {
    Name = "tf-test-pri"
  }

  tags = {
    app       = "tf-test"
    Environment = "dev"
  }

  vpc_tags = {
    Name = "vpc-name"
  }
}