resource "aws_subnet" "jenkins_subnet" {
  vpc_id                  = var.vpc_id
  cidr_block              = var.jenkins_subnet
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "jenkins-subnet"
  }
}

resource "aws_subnet" "db_subnet" {
  count = length(var.db_subnet)

  vpc_id            = var.vpc_id
  cidr_block        = element(var.db_subnet, count.index)
  availability_zone = element(["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c", "ap-northeast-2d"], count.index)

  tags = {
    Name = "db_subnet-${count.index + 1}"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = aws_subnet.db_subnet[*].id

  tags = {
    Name = "RDS Subnet Group"
  }
}