resource "aws_instance" "devops-2021" {
  ami           = var.ami_id
  instance_type = var.inst_type
  count = var.count_value

  tags = {
    Name = "pradeep-terraform"
  }
}
