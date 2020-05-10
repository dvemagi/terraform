# Terraform.tfvars per la creazione di un VPC
#
# Copyright (c) 2020 Dario Vemagi
# Under MIT License

# Nome che verrà attibuito al deploy. Tag app=deploy
env = "terra-mi"

# Indirizzo di base del VPC
CIDR = "172.31.252.0/22"

# Region AWS di deploy
region = "eu-south-1" # Milano
#region = "eu-west-1" # Dublino
#region = "eu-wes-2" # Francoforte  