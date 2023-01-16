module "vpc" {
  source              = "./Modules/VPC"
  region              = var.region
  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  publicsubnets_cidr  = var.publicsubnets_cidr
  privatesubnets_cidr = var.privatesubnets_cidr
  #databasesubnets_cidr = var.databasesubnets_cidr
  private_AZ = var.private_AZ
  public_AZ  = var.public_AZ

}

module "security_group" {
  source = "./Modules/Security_Group"
  vpc_id = module.vpc.vpc_id
 
}

module "ssh-key" {
  source = "./Modules/SSH-key"
}

module "ec2" {
  source              = "./Modules/EC2"
  jumpboxSG_id        = module.security_group.jumpboxSG_id
  WebSG_id            = module.security_group.WebSG_id
  RDSSG_id            = module.security_group.RDSSG_id
  APPSG_id            = module.security_group.AppSG_id
  publicsubnets_cidr  = module.vpc.public_subnets_id
  privatesubnets_cidr = module.vpc.private_subnets_id
}