variable "settings" {
    type = map(any)
    default = {
        "type" = "t2.medium"
        "count" = 1
        "key_name" = "lunch-key"
    }
}

variable "subnet_id" {
    type = string
}

variable "vpc_security_group_ids" {
    type = list(string)
}