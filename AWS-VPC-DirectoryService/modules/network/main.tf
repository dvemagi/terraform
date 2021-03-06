module  "vpc" {

  source = "terraform-aws-modules/vpc/aws"

  cidr = "10.0.0.0/16"

  azs             = ["eu-south-1a", "eu-south-1b"]
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
    Name      = "tf-test-vpc"
  }

}