variable "security_group" {
    type = string
}

variable "subnet_group_name" {
    type = string
}

variable "settings" {
    type = map(any)
    default = {
        "security_group" = "sg-0c0c146e420785fa8",
        "engine_version" = "8.0.35"
    }
}

variable "db_username" {
    type        = string
}

variable "db_password" {
    type        = string
}
