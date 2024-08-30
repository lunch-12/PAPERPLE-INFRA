variable "settings" {
  type = map(any)
  default = {
    "type"     = "t3.medium"
    "count"    = 1
    "key_name" = "lunch-key"
  }
  description = "Jenkins Server Instance Settings"
}

variable "subnet_id" {
  type        = string
  description = "Jenkins Server Subnet ID"
}

variable "vpc_security_group_ids" {
  type        = list(string)
  description = "VPC Security Group IDs"
}