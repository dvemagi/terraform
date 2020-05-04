# Modulo per la creazione di una active directory gestita 
# 
# i parametri vpc_id e subnet_ids sono passati dal main_tf preso da main.tf chiamante

resource "aws_directory_service_directory" "directory" {
  name     = "corp.notexample.com"
  password = "SuperSecretPassw0rd"
  edition = "Standard"
  type     = "MicrosoftAD"

 vpc_settings {
    vpc_id     = "${aws_vpc.vpc_id.ids.id}"
   subnet_ids = "${aws_subnet.sub.ids.id}"
}

  tags = {
    Project = "tf-test-ds"
  }
}