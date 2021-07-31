resource "aws_security_group" "terraform_sg" {
  name        = "terraform_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.vpc_demo.id
  depends_on = [aws_vpc.vpc_demo]

  ingress {
    description      = "TLS from VPC"
	@@ -19,9 +20,44 @@ resource "aws_instance" "devops-2021" {
  ami           = var.ami_id
  instance_type = var.inst_type
  count = var.count_value

    network_interface {
    network_interface_id = aws_network_interface.demo_interface.id
    device_index         = 0
  }


  tags = {
    Name = "pradeep-terraform"
  }
}

resource "aws_network_interface" "demo_interface" {
  subnet_id   = aws_subnet.subnet_demo.id
  private_ips = ["10.0.1.10"]
  security_groups  = [aws_security_group.terraform_sg.id]
  depends_on = [aws_subnet.subnet_demo, aws_security_group.terraform_sg]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_vpc" "vpc_demo" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "vpc-demo"
  }
}

resource "aws_subnet" "subnet_demo" {
  vpc_id     = aws_vpc.vpc_demo.id
  cidr_block = "10.0.1.0/24"
  depends_on = [aws_vpc.vpc_demo]

  tags = {
    Name = "Demo Subnet"
  }
}
