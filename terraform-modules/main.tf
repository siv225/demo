module "vpc" {
  source           = "./modules/network/vpc"
  name             = "myvpc-aug7th"
  cidr             = "10.0.0.0/16"
}

module "aws_subnet_az1" {
  source           = "./modules/network/subnet"
  aws_vpc_id       = "${module.vpc.my_vpc_id}"
  aws_subnet_cidr  = var.aws_subnet_cidr1
  aws_az_name      = var.aws_az_name1
}

module "aws_subnet_az2" {
  source           = "./modules/network/subnet"
  aws_vpc_id       = "${module.vpc.my_vpc_id}"
  aws_subnet_cidr  = var.aws_subnet_cidr2
  aws_az_name      = var.aws_az_name2
}

module "aws_subnet_az3" {
  source           = "./modules/network/subnet"
  aws_vpc_id       = "${module.vpc.my_vpc_id}"
  aws_subnet_cidr  = var.aws_subnet_cidr3
  aws_az_name      = var.aws_az_name3
}

module "aws" {
  source = "./modules/instance"
  ami_id = "ami-0233c2d874b811deb"
  count_value = 1
  inst_type = "t2.micro"
  subnet_id   = "${module.Subnet.subnet_7thAug.id}"

}
