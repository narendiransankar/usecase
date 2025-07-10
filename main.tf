module "vpc" {
  source = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  availability_zones  = var.availability_zones
}

module "ec2" {
  source = "./modules/ec2"

  ami_id     = var.ami_id
  subnet_ids = module.vpc.public_subnet_ids
  vpc_id     = module.vpc.vpc_id
  alb_security_group_id = module.loadbalancer.security_group_id
  
}

module "loadbalancer" {
  source = "./modules/loadbalancer"

  subnet_ids = module.vpc.public_subnet_ids
  vpc_id     = module.vpc.vpc_id
  instance_a_id      = module.ec2.instance_a_id
  instance_b_id      = module.ec2.instance_b_id
  instance_c_id      = module.ec2.instance_c_id
  alb_security_group_id = module.ec2.ec2_security_group_id
#   depends_on = [module.ec2]
}

