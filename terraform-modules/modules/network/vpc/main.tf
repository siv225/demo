resource "aws_vpc" "aws_vpc_aug7th" {
  cidr_block       = var.cidr
  instance_tenancy = "default"

  tags = {
    Name = "ModuleTestVPC"
  }
}
