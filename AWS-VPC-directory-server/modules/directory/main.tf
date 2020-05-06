# Modulo per la creazione di una active directory gestita 
# 
# i parametri vpc_id e subnet_ids sono passati dal main.tf chiamante

variable "vpc_id" {
  description = "id del vpc"
}

variable "subnet_ids"{
  description = "subnet private"
}

variable "password"{
  description = "password admin di Windows"
}

variable "env"{
  description = "nome dell'ambiente"
}

resource "aws_directory_service_directory" "ds" {
  name     = "${var.env}.demo"
  password = var.password
  edition = "Standard"
  type     = "MicrosoftAD"
  short_name = var.env

 vpc_settings {
    vpc_id     = var.vpc_id
    subnet_ids = var.subnet_ids
}

  tags = {
    app = var.env
    Name = "${var.env}-ds"
  }
}