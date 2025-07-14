variable "instance_type" {
  default = "t2.micro"
}
variable "ami" {
  default = "ami-0ed9f8d63c9e8b95a"
}

variable "vpc_id" {
  description = "this is ID "
}

variable "public_subnet_ids" {
  description = "this is subnet id"
}




