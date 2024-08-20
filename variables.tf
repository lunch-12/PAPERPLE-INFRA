variable "aws_region" {
  default = "ap-northeast-2"
}

variable "vpc_cidr_block" {
  default = "192.169.0.0/16"
}

variable "db_username" {
  type        = string
  sensitive   = true
}

variable "db_password" {
  type        = string
  sensitive   = true
}
