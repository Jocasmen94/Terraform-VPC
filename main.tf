#resource "aws_instance" "test" {
#  ami = "ami-08c40ec9ead489470"
#  instance_type = "t2.micro"
#}

provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket         = "jocasmen-terraform"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}


resource "aws_vpc" "main-1" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true

  tags = {
    Name = "Main VPC 1"
  }
}