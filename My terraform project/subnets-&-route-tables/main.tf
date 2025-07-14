resource "aws_subnet" "public_1a" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
  tags = { Name = "rafay-Public-Subnet1" }
}

resource "aws_subnet" "public_1b" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  map_public_ip_on_launch = true
  tags = { Name = "rafay-Public-Subnet2" }
}

resource "aws_subnet" "private_1a" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"
  tags = { Name = "rafay-Private-Subnet1" }
}

resource "aws_subnet" "private_1b" {
  vpc_id     = var.vpc_id
  cidr_block = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = { Name = "rafay-Private-Subnet2" }
}


resource "aws_route_table" "rafayPubRT" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway
  }

  tags = { Name = "rafayPubRT" }
}


# Associations
resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.rafayPubRT.id
}

resource "aws_route_table_association" "public_1b" {
  subnet_id      = aws_subnet.public_1b.id
  route_table_id = aws_route_table.rafayPubRT.id
}

resource "aws_route_table_association" "private_1a" {
  subnet_id      = aws_subnet.private_1a.id
  route_table_id = var.default_route_table_id
}

resource "aws_route_table_association" "private_1b" {
  subnet_id      = aws_subnet.private_1b.id
  route_table_id = var.default_route_table_id
}