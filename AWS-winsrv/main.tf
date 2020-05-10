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

variable "password" {
    type = string
    description = "Password da inserire"
}

variable "nome" {
    type = string
    description = "Nome istanza e del deploy"
}

variable "root_size" {
  type = string
  description = "Dimensione del disco di root"
}

# Provider 
provider "aws" {
  region = var.region
}

# modulo che recupera  ami più aggiornata per win2016 in questa region
# possibile cambiare English in Italian o altre lingue

data "aws_ami" "win2016" {
  most_recent = true

  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Full-Base-*"]
  }

  owners = ["amazon"] 
}

data "aws_subnet" "subnet" {
  id = var.subnet
}

resource "aws_security_group" "subnet" {
  vpc_id = data.aws_subnet.subnet.vpc_id

  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
  }
  tags = {
    app   = var.nome
    Name  = "${var.nome}-sg"
  }
}

module "win_instance" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = var.nome
  instance_count         = 1

  ami                    = data.aws_ami.win2016.id
  instance_type          = var.tipo
  vpc_security_group_ids = [aws_security_group.subnet.id]
  subnet_id              = var.subnet

root_block_device = [
    {
      volume_type = "gp2"
      volume_size = var.root_size
    },
  ]


  tags = {
    app   = var.nome
    Name = var.nome
  }

  volume_tags = {
    app   = var.nome
    Name = var.nome
  }
}
