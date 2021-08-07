resource "aws_subnet" "subnet_7thAug" {
  vpc_id            = var.aws_vpc_id
  cidr_block        = var.aws_subnet_cidr
  availability_zone = var.aws_az_name
  tags = {
    Name = "7thAug"
	}
}
