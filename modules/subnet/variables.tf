variable "public_subnet" {
    default = "192.169.0.0/24"
}

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

variable "eks_cluster_subnet" {
    default = [
        "192.169.2.0/24",
        "192.169.3.0/24",
    ]
}

variable "eks_node_group_subnet" {
    default = [
        "192.169.10.0/24",
        "192.169.11.0/24",
        "192.169.12.0/24",
        "192.169.13.0/24",
    ]
}

variable "vpc_id" {
    type = string
}

variable "cluster_name" {
    default = "paperple-cluster"
}