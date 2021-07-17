resource "aws_instance" "devops-2021" {
  ami           = "ami-0233c2d874b811deb"
  instance_type = "t2.micro"

  tags = {
    Name = "pradeep-terraform"
  }
}
