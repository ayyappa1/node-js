
terraform {
  backend "s3" {
    encrypt = "true"
    bucket  = "terraform-state-conference"
    region  = "us-east-1"
    key     = "jenkins/terraform.tfstate"
  }
}

provider "aws" {
  region                  = "${var.region}"
}

resource "aws_instance" "jenkins_master" {
  ami                    = "${data.aws_ami.jenkins-master.id}"
  instance_type          = "${var.jenkins_master_instance_type}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${aws_security_group.jenkins_master_sg.id}"]
  subnet_id              = "${element(var.vpc_private_subnets, 0)}"

  root_block_device {
    volume_type           = "gp2"
    volume_size           = 30
    delete_on_termination = false
  }

  tags {
    Name   = "jenkins_master"
    Author = "Ayyappa"
    Tool   = "Terraform"
  }

}
