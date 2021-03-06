variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "key" {}
variable "pem_file" {}
variable "simple-gitlab-runner-ami" {}
variable "gitlab_url" {}
variable "shell-runner-token" {}
variable "docker-runner-token" {}
variable "project" {}

provider "aws" {
  access_key     = "${var.access_key}"
  secret_key     = "${var.secret_key}"
  region         = "${var.region}"
}

resource "aws_instance" "simple-gitlab-runner" {
  ami                        = "${var.simple-gitlab-runner-ami}"
  instance_type              = "t2.micro"
  key_name                   = "${var.key}"
  associate_public_ip_address= true
  security_groups            = ["${aws_security_group.allow-all-inbound-ssh.name}"]
  tags {
    Name                     = "simple-gitlab-runner_${var.project}"
  }
  provisioner "remote-exec" {
    inline                   = [

      "sudo mkdir /root/.aws",
      "sudo sh -c \"echo '[default]\naws_access_key_id=${var.access_key}\naws_secret_access_key=${var.secret_key}' > /root/.aws/credentials\"",
      "sudo $(sudo PATH=$PATH:/root/.aws aws ecr get-login --no-include-email --region ${var.region})",

      "sudo gitlab-runner register --non-interactive --url ${var.gitlab_url} --registration-token ${var.shell-runner-token} --executor shell",
      "sudo gitlab-runner register --non-interactive --url ${var.gitlab_url} --registration-token ${var.docker-runner-token} --executor docker --docker-image debian:stretch",
    ]

    connection {
      user                   = "admin"
      private_key            = "${file(var.pem_file)}"
    }
  }
}

resource "aws_security_group" "allow-all-inbound-ssh" {
  name                       = "simple-gitlab-runner-security-group_${var.project}"
  description                = "allow only inbound SSH traffic"

  ingress {
    from_port                = 22
    to_port                  = 22
    protocol                 = "tcp"
    cidr_blocks              = ["0.0.0.0/0"]
  }

  egress {
    from_port                = 0
    to_port                  = 0
    protocol                 = "-1"
    cidr_blocks              = ["0.0.0.0/0"]
  }
}
