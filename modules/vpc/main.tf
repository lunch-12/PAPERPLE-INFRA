resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block

  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat-eip.id
  subnet_id     = var.public_subnet

  tags = {
    Name = "main-nat"
  }
}

resource "aws_nat_gateway" "db" {
  allocation_id = aws_eip.db-nat-eip.id
  subnet_id     = var.db_public_subnet

  tags = {
    Name = "db-main-nat"
  }
}

resource "aws_route_table" "igw-table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "main-igw-rtb"
  }
}

resource "aws_route_table" "nat-table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "main-nat-rtb"
  }
}

resource "aws_route_table" "db-nat-table" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.main.id
  }

  tags = {
    Name = "main-nat-rtb"
  }
}

resource "aws_eip" "nat-eip" {
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "db-nat-eip" {
  lifecycle {
    create_before_destroy = true
  }
}