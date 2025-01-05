#  SUBNET GROUP FOR RDS

resource "aws_db_subnet_group" "rafay-subnet-group" {
  name       = "examplmudze-subnet-group"
  subnet_ids =  [var.subnet_id,var.subnet_id2]

  tags = {
    Name = "rafay-subnet-group"
  }  
}

resource "aws_db_instance" "rafay-db" {
  allocated_storage    = 20
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "Password!123"    
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name  = aws_db_subnet_group.rafay-subnet-group.id
  multi_az              = false
  backup_retention_period = 7
  storage_type          = "gp2"
  publicly_accessible = false
}