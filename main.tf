module "vpc" {
  source = "./modules/vpc"

  public_subnet = module.subnet.public_subnet
  db_public_subnet = module.subnet.db_public_subnet
}

module "subnet" {
  source = "./modules/subnet"
  vpc_id = module.vpc.vpc_id
}

module "security_group" {
  source = "./modules/security_group"
  vpc_id = module.vpc.vpc_id
}

module "rds" {
  source            = "./modules/rds"
  db_username       = var.db_username
  db_password       = var.db_password
  security_group    = module.security_group.database
  subnet_group_name = module.subnet.aws_db_subnet_group_name
}

module "ec2" {
  source = "./modules/ec2"

  subnet_id              = module.subnet.jenkins_subnet
  vpc_security_group_ids = [module.security_group.main]
}

module "eks" {
  source = "./modules/eks"

  vpc_id                = module.vpc.vpc_id
  cluster_subnet_ids    = module.subnet.eks_cluster_subnet
  node_group_subnet_ids = module.subnet.eks_node_group_subnet
}

module "ecr" {
  source = "./modules/ecr"
}

resource "aws_route_table_association" "jenkins" {
  subnet_id      = module.subnet.jenkins_subnet
  route_table_id = module.vpc.igw-table
}

resource "aws_route_table_association" "rds" {
  count          = length(module.subnet.db_subnet)
  subnet_id      = module.subnet.db_subnet[count.index]
  route_table_id = module.vpc.db-nat-table   
}

resource "aws_route_table_association" "public_subnet" {
  subnet_id      = module.subnet.public_subnet
  route_table_id = module.vpc.igw-table
}

resource "aws_route_table_association" "db_public_subnet" {
  subnet_id      = module.subnet.db_public_subnet
  route_table_id = module.vpc.igw-table
}

resource "aws_route_table_association" "eks" {
  count          = length(module.subnet.eks_cluster_subnet)
  subnet_id      = module.subnet.eks_cluster_subnet[count.index]
  route_table_id = module.vpc.igw-table
}

resource "aws_route_table_association" "eks-node-group" {
  count          = length(module.subnet.eks_node_group_subnet)
  subnet_id      = module.subnet.eks_node_group_subnet[count.index]
  route_table_id = module.vpc.nat-table
}

resource "aws_eip" "current_ip" {
  instance = module.ec2.jenkins_instance_id
}