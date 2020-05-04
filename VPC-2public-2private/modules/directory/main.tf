# Modulo per la creazione di una active directory gestita 
# 
# i parametri vpc_id e subnet_ids sono passati dal main.tf chiamante

variabile "vpc_id"{
  description = "id del vpc"
  type = string
}

variabile "subnet_ids"{
  description = "id del vpc"
  type = string
}

resource "aws_directory_service_directory" "ds" {
  name     = "corp.notexample.com"
  password = "SuperSecretPassw0rd"
  edition = "Standard"
  type     = "MicrosoftAD"

 vpc_settings {
    vpc_id     = "${var.vpc_id}"
    subnet_ids = "${var.subnet_ids}"
}

  tags = {
    Project = "tf-test-ds"
  }
}