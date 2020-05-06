variable "vpc_id" {
  description = "id del vpc"
}

variable "subnet_ids"{
  description = "subnet private"
}

variable "env" {
  type = string
  description = "Nome dell'ambiente"
}

variable "ds_id" {
  type = string
  description = "ID della Directory Gestita"
}

resource "aws_workspaces_directory" "wks_ds" {
  directory_id = "${var.ds_id}"
  subnet_ids = var.subnet_ids


}

resource "null_resource" "create_user_demo01" {
  provisioner "local-exec"{
    command = "aws workdocs create-user --organization-id ${var.ds_id} --username demo01 --email-address demo01@${var.env}.demo --given-name demo01 --surname icsdemo --password DemoPassword0"
  }
}

resource "null_resource" "create_user_demo02" {
  provisioner "local-exec"{
    command = "aws workdocs create-user --organization-id ${var.ds_id} --username demo02 --email-address demo02@${var.env}.demo --given-name demo02 --surname icsdemo --password DemoPassword0"
  }
}


