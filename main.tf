provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source    = "./modules/vpc"
}

module "subnet" {
  source    = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
}

module "security_group" {
  source    = "./modules/security_group" 
  vpc_id    = module.vpc.vpc_id
}

module "rds" {
  source              = "./modules/rds"
  db_username         = var.db_username
  db_password         = var.db_password
  security_group      = module.security_group.database
  subnet_group_name   = module.subnet.aws_db_subnet_group_name
}

module "ec2" {
  source                 = "./modules/ec2"

  subnet_id              = module.subnet.jenkins_subnet
  vpc_security_group_ids = [module.security_group.main]
}

resource "aws_route_table_association" "jenkins" {
  subnet_id      = module.subnet.jenkins_subnet
  route_table_id = module.vpc.route_table
}

resource "aws_route_table_association" "rds" {
  count          = length(module.subnet.db_subnet)
  subnet_id      = module.subnet.db_subnet[count.index]
  route_table_id = module.vpc.route_table
}

resource "aws_eip" "current_ip" {
  instance = module.ec2.jenkins_instance_id
}