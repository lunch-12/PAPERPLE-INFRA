variable "security_group" {
  type        = string
  description = "RDS Security Group"
}

variable "subnet_group_name" {
  type        = string
  description = "RDS Subnet Group Name"
}

variable "settings" {
  type = map(any)
  default = {
    "security_group" = "sg-0c0c146e420785fa8",
    "engine_version" = "8.0.35"
  }
  description = "RDS Instance Settings"
}

variable "db_username" {
  type        = string
  description = "Paperple DB Username"
}

variable "db_password" {
  type        = string
  description = "Paperple DB Password"
}
