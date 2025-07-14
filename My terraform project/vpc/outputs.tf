output "vpc_id" {
  value = aws_vpc.main.id
}

output "internet_gateway" {
  value = aws_internet_gateway.rafay-igw.id
  
  }


output "default_route_table_id" {
  value = aws_vpc.main.default_route_table_id
}