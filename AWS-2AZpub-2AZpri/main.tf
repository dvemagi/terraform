
variable "env" {
  type        = string
  description = "Nome dell'ambiente"
}

variable "region" {
  type        = string
  description = "Region di AWS"
  default = eu-west-1
}

provider "aws" {
  region = "eu-west-1"
}

module "network" {
  source = "./modules/network/"
  env    = var.env
  region = var.region
}
