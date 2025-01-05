resource "aws_launch_template" "rafay_lt" {
  name   = "rafay_asg"
  image_id      =  var.aws_ami_from_instance
  instance_type = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.asg-sg.id ]
}

resource "aws_autoscaling_group" "rafay_asg" {
  vpc_zone_identifier = [var.subnet_id,var.subnet_id2 ]
  target_group_arns = [ var.target_group_arn ]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 1

  mixed_instances_policy {
    launch_template {
    launch_template_specification{
    launch_template_id = aws_launch_template.rafay_lt.id
  }
  }
  }
  
}

resource "aws_security_group" "asg-sg" {
  name   = "rafay-asg"
  vpc_id =  var.vpc_id
  

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
ingress {
  from_port   = 3389
  to_port     = 3389
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}

egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }
  tags = {
    name="rafay-asg-sg"
  }
}