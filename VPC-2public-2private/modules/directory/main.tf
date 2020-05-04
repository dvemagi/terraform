# Modulo per la creazione di una active directory gestita 
# 
# i parametri vpc_id e subnet_ids sono passati dal main.tf chiamante

resource "aws_directory_service_directory" "ds" {
  name     = "corp.notexample.com"
  password = "SuperSecretPassw0rd"
  edition = "Standard"
  type     = "MicrosoftAD"

 vpc_settings {
    vpc_id     = module.vpc_id
    subnet_ids = module.vpc.private_subnets
}

  tags = {
    Project = "tf-test-ds"
  }
}