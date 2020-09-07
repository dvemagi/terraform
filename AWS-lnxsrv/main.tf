# Creare una nuova istanza win 2016 usando la subnet esistente

variable "region" {
    type = string
    description = "Region AWs in cui effettuare il deploy"
}

variable "subnet" {
    type = string
    description = "subnet in cui effettuare il deploy"
}

variable "tipo" {
    type = string
    description = "Tipo di istanza"
}

variable "keyname" {
    type = string
    description = "Keypair"
}

variable "nome" {
    type = string
    description = "Nome istanza "
}

variable "app" {
    type = string
    description = "Tag app"
}

variable "root_size" {
  type = string
  description = "Dimensione del disco di root"
}

# Provider 
provider "aws" {
  region = var.region
}

# Recupero  ami più aggiornata per Amazon Linux 2.0 in questa region

data "aws_ami" "amz2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-2.0.*"]
  }

  owners = ["amazon"] 
}

# Recupero le informazioni dalla subnet id

data "aws_subnet" "subnet" {
  id = var.subnet
}

# Creo i security group per l'accesso

resource "aws_security_group" "subnet" {
  vpc_id = data.aws_subnet.subnet.vpc_id

  name = "${var.nome}-sg"
  description = "Security group per istanza ${var.nome}"

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
  }
  tags = {
    app   = var.app
  }
}

module "win_instance" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  associate_public_ip_address = true

  name                   = var.nome
  instance_count         = 1

  ami                    = data.aws_ami.amz2.id
  instance_type          = var.tipo
  key_namw               = var.keyname
  vpc_security_group_ids = [aws_security_group.subnet.id]
  subnet_id              = var.subnet


root_block_device = [
    {
      volume_type = "gp2"
      volume_size = var.root_size
    },
  ]


  tags = {
    app   = var.app
    Name = var.nome
  }

  volume_tags = {
    app   = var.app
    Name = var.nome
  }
}
