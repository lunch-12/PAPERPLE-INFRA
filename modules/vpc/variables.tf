variable "vpc_cidr_block" {
  default     = "192.169.0.0/16"
  description = "VPC CIDR Block"
}

variable "public_subnet" {
  type        = string
  description = "Public Subnet - NAT Gateway"
}

variable "db_public_subnet" {
  type        = string
  description = "DB Public Subnet - NAT Gateway"
}