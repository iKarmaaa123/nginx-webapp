module "vpcmodule" {
  source = "../../modules/VPC"
  vpc_cidr_block = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  vpc_name = var.vpc_name
  subnet_name = var.subnet_name
  environment = var.environment
  availability_zones = var.availability_zones
}

module "ec2module" {
  source = "../../modules/EC2"
  instance_type = var.instance_type
  ec2_count = var.ec2_count
  eip_count = var.eip_count
  environment = var.environment
  user_data = var.user_data
  subnet_ids = module.vpcmodule.subnet_ids
  vpc_id = module.vpcmodule.vpc_id
  security_group_ids = [module.vpcmodule.security_group_ids]
  domain = var.domain
}



