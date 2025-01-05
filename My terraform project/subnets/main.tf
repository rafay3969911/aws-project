resource "aws_subnet" "pub-sub1" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.1.0/24"
availability_zone = "us-east-1b"
  tags = {
    Name = "rafay-Public-Subnet1"
  }
}

resource "aws_subnet" "pvt-sub1" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.2.0/24"
availability_zone = "us-east-1a"
  tags = {
    Name = "rafay-Private-subnet1"
  }
}

resource "aws_subnet" "pub-sub2" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.3.0/24"
availability_zone = "us-east-1a"
  tags = {
    Name = "rafay-Public-Subnet2"

  }
}