resource "aws_instance" "jenkins" {
  ami                    = "ami-062cf18d655c0b1e8"
  instance_type          = var.settings.type
  key_name               = var.settings.key_name
  subnet_id              = var.subnet_id
  vpc_security_group_ids = var.vpc_security_group_ids

  root_block_device {
    volume_size = 20  # 볼륨 크기를 GB 단위로 설정
    delete_on_termination = true  # 인스턴스 종료 시 볼륨 삭제
  }

  tags = {
    Name = "jenkins-instance"
  }
}
