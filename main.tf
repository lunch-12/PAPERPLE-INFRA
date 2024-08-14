provider "aws" {
  region = var.aws_region
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  enable_dns_support = true  
  enable_dns_hostnames = true  

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "jenkins_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.jenkins_subnet
  availability_zone       = "ap-northeast-2a"
  map_public_ip_on_launch = true

  tags = {
    Name = "jenkins-subnet"
  }
}

resource "aws_subnet" "db_subnets" {
  count = length(var.db_subnet)

  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.db_subnet, count.index)
  availability_zone = element(["ap-northeast-2a", "ap-northeast-2b", "ap-northeast-2c", "ap-northeast-2d"], count.index)

  tags = {
    Name = "db_subnet-${count.index + 1}"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "rds-subnet-group"
  subnet_ids = aws_subnet.db_subnets[*].id

  tags = {
    Name = "RDS Subnet Group"
  }
}

resource "aws_db_instance" "paperple" {
  db_name                 = "paperpledb"
  identifier              = "paperple-db"
  engine                  = "mysql"  
  engine_version          = var.settings.database.engine_version
  instance_class          = "db.t3.micro" 
  allocated_storage       = 20
  db_subnet_group_name    = aws_db_subnet_group.default.name
  vpc_security_group_ids  = [aws_security_group.database.id] 
  username                = var.db_username  
  password                = var.db_password  
  skip_final_snapshot     = true  
  publicly_accessible     = true

  tags = {
    Name = "paperple DB instance"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "main-route-table"
  }
}

resource "aws_route_table_association" "jenkins" {
  subnet_id      = aws_subnet.jenkins_subnet.id
  route_table_id = aws_route_table.main.id
}

resource "aws_route_table_association" "rds" {
  count          = length(aws_subnet.db_subnets)
  subnet_id      = aws_subnet.db_subnets[count.index].id
  route_table_id = aws_route_table.main.id
}

resource "aws_security_group" "main" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "main-sg"
  }
}

resource "aws_security_group" "database" {
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "db-sg"
  }
}

resource "aws_instance" "jenkins" {
  ami           = "ami-062cf18d655c0b1e8"
  instance_type = var.settings.instance.type
  key_name      = var.settings.instance.key_name
  subnet_id     = aws_subnet.jenkins_subnet.id
  vpc_security_group_ids = [aws_security_group.main.id]

  tags = {
    Name = "jenkins-instance"
  }
}

resource "aws_eip" "current_ip" {
  instance = aws_instance.jenkins.id
}

output "jenkins_instance_ip" {
  value = aws_instance.jenkins.public_ip
}
