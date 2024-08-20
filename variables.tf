variable "aws_region" {
  default     = "ap-northeast-2"
  description = "AWS Region"
}

variable "vpc_cidr_block" {
  default     = "192.169.0.0/16"
  description = "VPC CIDR Block"
}

variable "db_username" {
  type        = string
  sensitive   = true
  description = "Paperple RDS Username"
}

variable "db_password" {
  type        = string
  sensitive   = true
  description = "Paperple RDS Password"
}
