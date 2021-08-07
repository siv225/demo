module "aws_vpc_aug7th" {
  source           = "./modules/network/vpc"
  aws_vpc_cidr	   = var.aws_vpc_cidr
}

module "aws_subnet_az1" {
  source           = "./modules/network/subnet"
  aws_vpc_id       = var.aws_vpc_id
  aws_subnet_cidr  = var.aws_subnet_cidr1 
  aws_az_name      = var.aws_az_name1 
}

module "aws_subnet_az2" {
  source           = "./modules/network/subnet"
  aws_vpc_id       = var.aws_vpc_id
  aws_subnet_cidr  = var.aws_subnet_cidr2
  aws_az_name      = var.aws_az_name2
}

module "aws_subnet_az3" {
  source           = "./modules/network/subnet"
  aws_vpc_id       = var.aws_vpc_id
  aws_subnet_cidr  = var.aws_subnet_cidr3
  aws_az_name      = var.aws_az_name3
}
