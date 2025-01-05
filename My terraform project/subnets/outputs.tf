output "subnet_id" {
  value = aws_subnet.pub-sub1.id
}

output "subnet_id_vpc" {
  value = aws_subnet.pvt-sub1.id
}

output "subnet_id2" {
  value = aws_subnet.pub-sub2.id
}
