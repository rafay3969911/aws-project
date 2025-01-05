resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "rafay_vpc"
  }
}



# internet gateway
resource "aws_internet_gateway" "mudz-igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "rafay-igway"
  }
}