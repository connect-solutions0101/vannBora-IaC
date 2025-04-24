module "ec2" {
  source = "./ec2/"
  instance_security_grupo = module.vpc.instance_security_grupo
  instance_vpc = module.vpc.id_vpc
  instance_public_subnet = module.public_subnet_terraform.id_subnet
  instance_private_subnet = module.private_subnet_terraform.id_subnet
}

module "vpc" {
  source = "./vpc/"
  variable_subnet_id_public = module.public_subnet_terraform.id_subnet
  variable_subnet_id_private = module.private_subnet_terraform.id_subnet
}

module "private_subnet_terraform" {
  source = "./subnet/private_subnet/"
  variable_id_vpc = module.vpc.id_vpc
}

module "public_subnet_terraform" {
  source = "./subnet/public_subnet/"
  variable_id_vpc = module.vpc.id_vpc
}