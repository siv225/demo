resource "aws_vpc" "new-vpc1" {
    cidr_block       = "10.0.0.0/16"
    instance_tenancy = "default"

  tags = {
     Name = "new-vpc1"
    }
}

resource "aws_vpc" "new-vpc2" {
    cidr_block       = "172.0.0.0/16"
    instance_tenancy = "default"

  tags = {
     Name = "new-vpc2"
    }
}
resource "aws_subnet" "Sub-vpc1" {
    vpc_id     = aws_vpc.new-vpc1.id
    cidr_block = "10.0.1.0/24"
    depends_on = [aws_vpc.new-vpc1]
  tags = {
      Name = "Sub-vpc1"
    }
}

resource "aws_subnet" "Sub-vpc2" {
    vpc_id     = aws_vpc.new-vpc2.id
    cidr_block = "172.0.1.0/24"
    depends_on = [aws_vpc.new-vpc2]
  tags = {
      Name = "Sub-vpc2"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.new-vpc2.id
    depends_on = [aws_vpc.new-vpc2]
}

resource "aws_vpc_peering_connection" "Peering" {
  peer_vpc_id   = aws_vpc.new-vpc2.id
  vpc_id        = aws_vpc.new-vpc1.id
  auto_accept   = true
  depends_on    = [ aws_vpc.new-vpc2,aws_vpc.new-vpc1 ]

  tags = {
    Name = "VPC Peering between vpc1 and vpc2"
  }
}

resource "aws_default_route_table" "defroute_new-vpc2" {
  default_route_table_id = aws_vpc.new-vpc2.default_route_table_id

    route = [
    {
     cidr_block                = "0.0.0.0/0"
     egress_only_gateway_id    = ""
     gateway_id                = aws_internet_gateway.igw.id
     instance_id               = ""
     ipv6_cidr_block           = ""
     nat_gateway_id            = ""
     network_interface_id      = ""
     transit_gateway_id        = ""
     vpc_peering_connection_id = ""
     destination_prefix_list_id = ""
     vpc_endpoint_id = ""
    }
  ]
  depends_on = [aws_vpc.new-vpc2]

  tags = {
    Name = "defroute_new-vpc2"
  }
}

resource "aws_default_route_table" "defroute_new-vpc1" {
  default_route_table_id = aws_vpc.new-vpc1.default_route_table_id

    route = [
    {
     cidr_block                = "0.0.0.0/0"
     egress_only_gateway_id    = ""
     gateway_id                = ""
     instance_id               = ""
     ipv6_cidr_block           = ""
     nat_gateway_id            = aws_nat_gateway.Nat-Vpc1.id
     network_interface_id      = ""
     transit_gateway_id        = ""
     vpc_peering_connection_id = ""
     destination_prefix_list_id = ""
     vpc_endpoint_id = ""
    }
  ]
  depends_on = [aws_vpc.new-vpc1,aws_nat_gateway.Nat-Vpc1]

  tags = {
    Name = "defroute_new-vpc1"
  }
}
resource "aws_nat_gateway" "Nat-Vpc1" {
    connectivity_type = "private"
    subnet_id         = aws_subnet.Sub-vpc2.id
    depends_on = [aws_subnet.Sub-vpc2,aws_internet_gateway.igw]
}


resource "aws_instance" "ec2-main-private" {
    ami           = var.ami_id
    instance_type = var.inst_type
    count = var.count_value
    associate_public_ip_address = false
    subnet_id   = aws_subnet.Sub-vpc1.id

  tags = {
      Name = "ec2-main"
    }
}

resource "aws_instance" "ec2-public" {
    ami           = var.ami_id
    instance_type = var.inst_type
    count = var.count_value
    associate_public_ip_address = true
    subnet_id   = aws_subnet.Sub-vpc2.id

   tags = {
      Name = "ec2-public"
    }
}
