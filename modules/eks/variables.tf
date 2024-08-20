variable "cluster_name" {
  type        = string
  default     = "paperple-cluster"
  description = "EKS Cluster Name"
}

variable "cluster_subnet_ids" {
  type        = list(string)
  description = "EKS Cluster Subnet IDs - public"
}

variable "node_group_subnet_ids" {
  type        = list(string)
  description = "EKS NodeGroup Subnet IDs - private"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID"
}