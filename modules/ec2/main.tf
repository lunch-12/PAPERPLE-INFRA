resource "aws_instance" "jenkins" {
  ami                    = "ami-062cf18d655c0b1e8"
  instance_type          = var.settings.type
  key_name               = var.settings.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  tags = {
    Name = "jenkins-instance"
  }
}

