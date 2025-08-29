module "vpc" {
  source = "./vpc-subnets"
}

module "vm-machines" {
  source = "./vm-machines"
  vpc_network = module.vpc.vpc_network
  public_subnet_1 = module.vpc.public_subnet_1
  public_subnet_2 = module.vpc.public_subnet_2
}

module "Machine-Template" {
  source = "./Machine-template"
  private_subnet_1 = module.vpc.private_subnet_1
  rafay_custom_image = module.vm-machines.rafay_custom_image
}

module "Autoscaling" {
  source = "./Autoscaling"
  rafay_template = module.Machine-Template.rafay_template
  health_check = module.load_balancing.health_check
  
}

module "load_balancing" {
  source = "./Loadbalancer"
  rafay_mig = module.Autoscaling.rafay_mig
  mig_self_link = module.Autoscaling.mig_self_link
  vpc_network = module.vpc.vpc_network
  private_subnet_1 = module.vpc.private_subnet_1
}