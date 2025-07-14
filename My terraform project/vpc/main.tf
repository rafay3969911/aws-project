resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "rafay_vpc"
  }
}

resource "aws_default_route_table" "rafayPvtRT" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  tags = {
    Name = "rafayPvtRT"
  }
}


# internet gateway
resource "aws_internet_gateway" "rafay-igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "rafay-igway"
  }
}




