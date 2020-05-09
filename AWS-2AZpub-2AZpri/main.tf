
variable "env" {
  type        = string
  description = "Nome dell'ambiente"
}

variable "region" {
  type        = string
  description = "Region di AWS"
  default = "eu-west-1"
}

variable "CIDR" {
  type = string
}

provider "aws" {
  region = var.regionterra
}

module "network" {
  source = "./modules/network/"
  env    = var.env
  region = var.region
  CIDR = var.CIDR
}
