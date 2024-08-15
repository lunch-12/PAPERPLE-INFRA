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