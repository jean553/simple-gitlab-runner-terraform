variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "simple-gitlab-runner-ami" {}

resource "aws_instance" "simple-gitlab-runner" {
  ami                        = "${var.kubernetes-ami}"
  instance_type              = "t2.micro"
  associate_public_ip_address= true
  tags {
    Name                     = "simple-gitlab-runner"
  }
  provisioner "local-exec" {
    command                  = "./firstboot.sh"
  }
}
