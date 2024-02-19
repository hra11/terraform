# terraform block
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.3.0"
    }
  }
}

# provider block
provider "aws" {
  region = "ap-southeast-1" #Asia Pacific (Singapore)#
}


# Data source:  Get AMI ID for Amazon Linux2 OS
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-*-gp2"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}


# ec2 instance
resource "aws_instance" "instance" {
  ami           = data.aws_ami.amazon_linux_2.id
  instance_type = "t2.micro"
  key_name      = "hammy-singapore-key"
  tags = {
    Name = "demo-instance"
  }
}
