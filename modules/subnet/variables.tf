variable "public_subnet" {
  default     = "192.169.0.0/24"
  description = "Public Subnet - NAT Gateway Subnet"
}

variable "db_public_subnet" {
  default     = "192.169.20.0/24"
  description = "Public Subnet - NAT Gateway Subnet"
}

variable "jenkins_subnet" {
  default     = "192.169.1.0/24"
  description = "Jenkins Server Instance Subnet"
}

variable "db_subnet" {
  default = [
    "192.169.192.0/20",
    "192.169.208.0/20",
    "192.169.224.0/20",
    "192.169.240.0/20"
  ]
  description = "RDS Subnets"
}

variable "eks_cluster_subnet" {
  default = [
    "192.169.2.0/24",
    "192.169.3.0/24",
  ]
  description = "EKS Cluster Subnets - public"
}

variable "eks_node_group_subnet" {
  default = [
    "192.169.10.0/24",
    "192.169.11.0/24",
    "192.169.12.0/24",
    "192.169.13.0/24",
  ]
  description = "EKS NodeGroup Subnets - private"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "cluster_name" {
  default = "paperple-cluster"
}