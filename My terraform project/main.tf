provider "aws" {
  region     = var.aws_region
  access_key = var.access_key
  secret_key = var.secret_key
}

module "vpc" {
  source = "./vpc"
}

module "subnets" {
  source = "./subnets"
  vpc_id = module.vpc.vpc_id


}

module "Routes-Tables" {
  source               = "./Routes-Tables"
  subnet_id            = module.subnets.subnet_id
  subnet_id_vpc        = module.subnets.subnet_id_vpc
  aws_internet_gateway = module.vpc.aws_internet_gateway
  vpc_id               = module.vpc.vpc_id



}

module "EC2" {
  source    = "./EC2"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.subnets.subnet_id
}




module "Load-balancer" {
  source    = "./Load-balancer"
  vpc_id    = module.vpc.vpc_id
  subnet_id = module.subnets.subnet_id
  pub_sub2  = module.subnets.subnet_id2



}

module "autoscaling" {
  source                = "./autoscaling"
  subnet_id             = module.subnets.subnet_id
  aws_ami_from_instance = module.EC2.aws_ami_from_instance
  subnet_id2            = module.subnets.subnet_id2
  target_group_arn      = module.Load-balancer.target_group_arn
  vpc_id                = module.vpc.vpc_id
}

module "rds" {
  source = "./rds"
  subnet_id = module.subnets.subnet_id
  subnet_id2 = module.subnets.subnet_id2
}

module "rafay_test_s3_bucket" {
  source      = "./S3 bucket"
  bucket_name = "rafay-test-bucket-${random_id.suffix.hex}"
  tags = {
    Environment = "Test"
    Project     = "LowCostS3"
  }
}

resource "random_id" "suffix" {
  byte_length = 4
}
