variable "jenkins_subnet" {
    default = "192.169.1.0/24"
}

variable "db_subnet" {
    default = [
        "192.169.192.0/20",
        "192.169.208.0/20",
        "192.169.224.0/20",
        "192.169.240.0/20"
    ]
}

variable "vpc_id" {
    type = string
}