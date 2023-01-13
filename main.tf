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

resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.main-1.id
  cidr_block = "10.0.10.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-east-1b"

  tags = {
    Name = "Subnet-1"
  }
}

resource "aws_internet_gateway" "gw-1" {
  vpc_id = aws_vpc.main-1.id

  tags = {
    Name = "GW-1"
  }
}

resource "aws_route_table" "r" {
  vpc_id = aws_vpc.main-1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw-1.id
  }
  
  tags = {
    Name = "Route-Table-1"
  }
}

resource "aws_route_table_association" "table_subnet1" {
  subnet_id = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.r.id
}



















