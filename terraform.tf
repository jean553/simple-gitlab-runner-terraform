variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "simple-gitlab-runner-ami" {}

provider "aws" {
  access_key     = "${var.access_key}"
  secret_key     = "${var.secret_key}"
  region         = "${var.region}"
}

resource "aws_instance" "simple-gitlab-runner" {
  ami                        = "${var.simple-gitlab-runner-ami}"
  instance_type              = "t2.micro"
  associate_public_ip_address= true
  tags {
    Name                     = "simple-gitlab-runner"
  }
  provisioner "local-exec" {
    command                  = "./firstboot.sh"
  }
}
