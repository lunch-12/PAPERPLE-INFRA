variable "cluster_name" {
    type = string
    default = "paperple-cluster"
}

variable "cluster_subnet_ids" {
    type = list(string)
}

variable "node_group_subnet_ids" {
    type = list(string)
}

variable "vpc_id" {
    type = string
}