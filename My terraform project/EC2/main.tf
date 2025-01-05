# resource "aws_instance" "Web-server" {
#   key_name = aws_key_pair.rafay-key.id
#   ami           = var.ami
#   instance_type = var.instance_type
#   security_groups = [aws_security_group.IIS-server.id]
#   tags = {
#     Name = "rafay-Web"
#   }
# }
resource "aws_instance" "Web-server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  tags = {
    Name = "rafayWebServer"
  }
}



}

# IIS server EC2
resource "aws_instance" "IIS-server" { 
  ami                     = var.ami
  key_name = aws_key_pair.rafay-key.id
  instance_type           = var.instance_type
  associate_public_ip_address = "true"  
  subnet_id = var.subnet_id
  vpc_security_group_ids = [aws_security_group.IIS-server.id]
  user_data = <<-EOF
    <powershell>
    Install-WindowsFeature -Name Web-Server -IncludeManagementTools
    </powershell>
  EOF

tags  = {
  Name = "rafay-IIS-server"
}
 


}

resource "aws_security_group" "web_sg" {
  name_prefix = "web-sg-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "IIS-server" {
  name_prefix = "rafay-iis-sg"
  vpc_id = var.vpc_id
  

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
    name = "rafay-IIS-server-sg"
  }
}


# create AMI from instance
resource "aws_ami_from_instance" "rafay-ami" {
  name               = "rafay-ami"
  source_instance_id = aws_instance.IIS-server.id
  # Optionally, you can specify other properties like description and tags
  description = "AMI FOR IIS SERVER"
  tags = {
    Name = "rafay-IIS-ami"
  }
}


  




 


