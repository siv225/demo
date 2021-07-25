resource "aws_security_group" "terraform_sg" {
  name        = "terraform_sg"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.aws_vpc_id

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  tags = {
    Name = "allow_tls"
  }
}

resource "aws_instance" "devops-2021" {
  ami           = var.ami_id
  instance_type = var.inst_type
  count = var.count_value
  security_groups  = [aws_security_group.terraform_sg.name]

  tags = {
    Name = "pradeep-terraform"
  }
}
