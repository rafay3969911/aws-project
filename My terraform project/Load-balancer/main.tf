# Application Load Balancer
resource "aws_lb" "rafay-lb" {
  name               = "rafay-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.rafay-ld-sg.id]
  subnets            = [var.public_subnet_ids[0],var.public_subnet_ids[1]]

  enable_deletion_protection = false

 
  tags = {
   Name = "rafay-lb"
  }
}
# Load Balancer Security-Group
resource "aws_security_group" "rafay-ld-sg" {
  name        = "load-balancer-sg"
  description = "Security group for the load balancer"
  vpc_id      =  var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rafay-load-balancer-sg"
  }
  
  }


# Load Balancer's target group
resource "aws_lb_target_group" "rafay-tg" {
  name     = "LB-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
  tags = {
    name = "rafay-tg"
  }
}



# Listener
resource "aws_lb_listener" "rafay_lis" {
  load_balancer_arn = aws_lb.rafay-lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.rafay-tg.arn
  }
  tags = {
    name = "rafay-lis"
  }
}