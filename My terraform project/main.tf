provider "aws" {
  region = var.aws_region
  secret_key = var.secret_key
  access_key = var.access_key
}

module "vpc" {
  source = "./vpc"
}

module "subnets" {
  source = "./subnets-&-route-tables"
  vpc_id = module.vpc.vpc_id
  internet_gateway = module.vpc.internet_gateway
  default_route_table_id = module.vpc.default_route_table_id
}


module "EC2" {
  source    = "./EC2"
  vpc_id    = module.vpc.vpc_id
  public_subnet_ids = module.subnets.public_subnet_ids
}




module "Load-balancer" {
  source    = "./Load-balancer"
  vpc_id    = module.vpc.vpc_id
  public_subnet_ids = module.subnets.public_subnet_ids
  private_subnet_ids = module.subnets.private_subnet_ids
}



module "autoscaling" {
  source                = "./autoscaling"
  public_subnet_ids = module.subnets.public_subnet_ids
  aws_ami_from_instance = module.EC2.aws_ami_from_instance
  private_subnet_ids = module.subnets.private_subnet_ids
  target_group_arn      = module.Load-balancer.target_group_arn
  vpc_id                = module.vpc.vpc_id
}

module "rds" {
  source = "./rds"
 public_subnet_ids = module.subnets.public_subnet_ids
private_subnet_ids = module.subnets.private_subnet_ids
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
