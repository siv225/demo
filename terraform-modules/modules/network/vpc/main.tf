resource "aws_vpc" "vpc_7thAug" {
  cidr_block       = var.aws_vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "7thAug"
  }
}
