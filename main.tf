terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"


  tags = {
    Name = "main-terraform"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = "vpc-054ac745b0eab8ca1"
}

resource "aws_route_table" "public" {
  vpc_id = "vpc-054ac745b0eab8ca1"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-0b164fde0b09bd740"
  }

  tags = {
    Name = "Public Route Table"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "vpc-054ac745b0eab8ca1"

  tags = {
    Name = "Private Route Table"
  }
}

resource "aws_subnet" "subnet_1" {
  vpc_id                  = "vpc-054ac745b0eab8ca1"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet 1"
  }
}

resource "aws_subnet" "subnet_2" {
  vpc_id                  = "vpc-054ac745b0eab8ca1"
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true

  tags = {
    Name = "Subnet 2"
  }
}

resource "aws_subnet" "subnet_3" {
  vpc_id     = "vpc-054ac745b0eab8ca1"
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "Subnet 3"
  }
}

resource "aws_subnet" "subnet_4" {
  vpc_id     = "vpc-054ac745b0eab8ca1"
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "Subnet 4"
  }
}
resource "aws_route_table_association" "public_1" {
  subnet_id      = "subnet-04b3e77e49eee1302"
  route_table_id = "rtb-02131a0d983e9b57c"
}

resource "aws_route_table_association" "public_2" {
  subnet_id      = "subnet-02ac0860ef3fb0536"
  route_table_id = "rtb-02131a0d983e9b57c"
}

resource "aws_route_table_association" "private_1" {
  subnet_id      = "subnet-015387c6dc9e41c66"
  route_table_id = "rtb-00c55904c6df13ada"
}

resource "aws_route_table_association" "private_2" {
  subnet_id      = "subnet-062691245e671a45f"
  route_table_id = "rtb-00c55904c6df13ada"
}
