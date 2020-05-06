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
  directory_id = var.ds_id
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

resource "local_file" "wks01" {
    content     = <<EOF
    {
             "Workspaces" : [
                      {
                      "DirectoryId" : "${var.ds_id}"",
                      "UserName" : "demo01",
                      "BundleId" : "wsb-bh8rsxt14",
                      "WorkspaceProperties": {
                          "RunningMode": "AUTO_STOP", 
                          "RunningModeAutoStopTimeoutInMinutes": 60 
                           }  
                    }
                   ]
          }
    EOF
    filename = "./files/wks01.json"
}

resource "null_resource" "create_wks01" {
  provisioner "local-exec"{
    command = "aws workdocs workspaces create-workspaces --cli-input-json ./files/wks01.json "
  }
}

resource "local_file" "wks02" {
    content     = <<EOF
    {
             "Workspaces" : [
                      {
                      "DirectoryId" : "${var.ds_id}"",
                      "UserName" : "demo02",
                      "BundleId" : "wsb-clj85qzj1",
                      "WorkspaceProperties": {
                          "RunningMode": "AUTO_STOP", 
                          "RunningModeAutoStopTimeoutInMinutes": 60 
                           }  
                    }
                   ]
          }
    EOF
    filename = "./files/wks02.json"
}

resource "null_resource" "create_wks02" {
  provisioner "local-exec"{
    command = "aws workdocs workspaces create-workspaces --cli-input-json ./files/wks02.json "
  }
}
