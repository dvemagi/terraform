# Modulo per la creazione di una active directory gestita 
# prendendo i dati da un terraform root 

# recupero delle info del vpc

data "aws_subnet_ids" "sub_priv" {
    module.vpc.private_subnets
}

data "aws_vpc" "vpc_id" {
    module.vpc.vpc_id
}

#

resource "aws_directory_service_directory" "directory" {
  name     = "corp.notexample.com"
  password = "SuperSecretPassw0rd"
  size     = "Small"

  vpc_settings {
    vpc_id     = "${aws_vpc.vpc_id.id}"
    subnet_ids = ["${aws_subnet.sub_priv.id[0],aws_subnet.sub_priv.id[1]}",]
  }

  tags = {
    Project = "tf-test-ds"
  }
}