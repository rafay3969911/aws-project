output "vpc_id" {
  value = aws_vpc.main.id
}

output "aws_internet_gateway" {
  value = aws_internet_gateway.mudz-igw.id
  
  }

