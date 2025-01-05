# Public RT
resource "aws_route_table" "public-route" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.aws_internet_gateway
  }

  tags = {
    Name = "rafay-Pub-RT"
  }
}
# private RT

resource "aws_route_table" "Private-Route" {
  vpc_id = var.vpc_id

  
  tags = {
    Name = "rafay-Pvt-RT"
  }
}

# public subnet association
resource "aws_route_table_association" "public-sub-association" {
  subnet_id      = var.subnet_id
  route_table_id = aws_route_table.public-route.id
}
# private subnet association 
resource "aws_route_table_association" "private-subnet-association" {
  subnet_id     = var.subnet_id_vpc
  route_table_id = aws_route_table.Private-Route.id
}
