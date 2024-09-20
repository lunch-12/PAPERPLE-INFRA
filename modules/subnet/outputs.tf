output "public_subnet" {
  value = aws_subnet.public_subnet.id
}

output "db_public_subnet" {
  value = aws_subnet.db_public_subnet.id
}

output "jenkins_subnet" {
  value = aws_subnet.jenkins_subnet.id
}

output "db_subnet" {
  value = aws_subnet.db_subnet[*].id
}

output "aws_db_subnet_group" {
  value = aws_db_subnet_group.default.id
}

output "aws_db_subnet_group_name" {
  value = aws_db_subnet_group.default.name
}

output "eks_cluster_subnet" {
  value = aws_subnet.eks_cluster_subnet[*].id
}

output "eks_node_group_subnet" {
  value = aws_subnet.eks_node_group_subnet[*].id
}